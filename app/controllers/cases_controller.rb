# frozen_string_literal: true

class CasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy, :link]

  # GET /cases or /cases.json
  def index
    @tcases = query_cases(query_params, {})
    @tprocesses = TestCase.where(project_id: @tcases.pluck(:project_id).uniq).order(:position)

    @page, @pagy, @cases = pagy_results(@tcases)

    respond_to do |format|
      format.html
      format.xlsx
      format.json { render json: @tcases.to_json }
    end
  end

  # GET /cases/1 or /cases/1.json
  def show
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  def link
    ticket_id = params[:ticket_id]
    @case.update ticket_id: ticket_id if ticket_id

    redirect_to edit_case_path(@case)
  end

  # POST /cases or /cases.json
  def create
    @case = Case.new(case_params)

    respond_to do |format|
      if @case.save
        format.html { redirect_to cases_path, notice: "Case was successfully created." }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1 or /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to cases_path, notice: "Case was successfully updated." }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1 or /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: "Case was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    @project = Project.first

    Case.where(project: @project).update_all("previous_status = status, previous_stage = stage")

    @import_errors = []
    spreadsheet = Roo::Spreadsheet.open(params[:file].path)
    spreadsheet.default_sheet = spreadsheet.sheets.first
    @import_data = []
    spreadsheet.each(case_no: "Project Case Number",
                     project_no: "Project ID",
                     subject: "Subject",
                     priority: "Priority",
                     product: "Product",
                     module: "Module",
                     status: "Status",
                     stage: "Stage",
                     assigned_to: "Assigned To") do |hash|
      @import_data << hash.merge(project_id: @project.id)
    end

    Case.import @import_data, on_duplicate_key_update: { conflict_target: [:case_no, :project_id], columns: [:project_no, :subject, :priority, :product, :module, :status, :assigned_to, :stage] }, returning: :case_no
    import_with_id = Case.find_by(case_no: "Project Case Number")
    import_with_id&.destroy
    redirect_to cases_path, notice: "Cases imported and customer status is being updated!"
  end

  private

  def permitted_order_columns
    %w[case_no subject priority stage status assigned_to]
  end

  def query_cases(query_params, args = {})
    @case_status = session[:case_case_status]&.split(",") || "New,In Progress,With Customer,With Development,On Hold - Being Monitored".split(",")
    @case_no = session[:case_case_no]&.split(",") || %w[]
    @case_priority = session[:case_case_priority]&.split(",") || %w[]
    @case_tracked = session[:case_case_tracked] || false
    args = args.merge({ status: @case_status }) if @case_status.length.positive?
    args = args.merge({ case_no: @case_no }) if @case_no.length.positive?
    args = args.merge({ priority: @case_priority }) if @case_priority.length.positive?
    args = args.merge({ tracked: @case_tracked }) if @case_tracked 
    query = Case.where(args)
    query = query.where("lower(case_no) LIKE :keyword OR lower(subject) LIKE :keyword OR lower(tags) LIKE :keyword", keyword: "%#{query_params[:keywords].downcase}%") if query_params && query_params[:keywords]

    order_by = permitted_column_name(permitted_order_columns, session[session_symbol("order_by")])
    order_by == "case_no" ? "case_no::integer" : order_by

    query.order("#{order_by} #{permitted_direction(session[session_symbol("direction")] || "desc")}")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = Case.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def case_params
    params.require(:case).permit(:tracked, :case_no, :notes, :tags, :current_status, :next_steps, :external_no, :target_build, :author, :case_type, :title, :case_status, :assigned_to, :case_priority, :application_name, :project_id)
  end
end
