# frozen_string_literal: true

class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_issue, only: [:show, :edit, :update, :destroy, :link]

  # GET /issues or /issues.json
  def index
    @tissues = query_issues(query_params, { issue_status: "assigned", issue_type: %w[Issue Defect], issue_priority: %w[2-high 1-showstopper] })

    @page, @pagy, @issues = pagy_results(@tissues)

    respond_to do |format|
      format.html
      format.xlsx
      format.json { render json: @issues.to_json }
    end
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  def link
    ticket_id = params[:ticket_id]
    @issue.update ticket_id: ticket_id if ticket_id

    redirect_to edit_issue_path(@issue)
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to issues_path, notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to issues_path, notice: "Issue was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    @project = Project.first

    @import_errors = []
    spreadsheet = Roo::Spreadsheet.open(params[:file].path)
    spreadsheet.default_sheet = "Data"
    @import_data = []
    spreadsheet.each(issue_no: "ID",
                     external_no: "External Reference",
                     target_build: "Target Build",
                     author: "Author",
                     issue_type: "Type",
                     title: "Title",
                     issue_status: "Status",
                     assigned_to: "Assigned To",
                     issue_priority: "Priority",
                     application_name: "Application") do |hash|
      @import_data << hash.merge(project_id: @project.id)
    end

    import_result = Issue.import @import_data, on_duplicate_key_update: { conflict_target: [:issue_no, :project_id], columns: [:external_no, :target_build, :author, :issue_type, :title, :issue_status, :assigned_to, :issue_priority, :application_name] }, returning: :issue_no
    redirect_to issues_path, notice: "Updates #{import_result.num_inserts}"
  end

  private

  def permitted_order_columns
    %w[ticket_no title]
  end

  def query_issues(query_params, args = {})
    query = Issue.includes(:ticket).where(args)
    query = query.where("lower(issue_no) LIKE :keyword OR lower(title) LIKE :keyword", keyword: "%#{query_params[:keywords].downcase}%") if query_params && query_params[:keywords]
    query.order("issue_no::integer ASC")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def issue_params
    params.require(:issue).permit(:issue_no, :notes, :tags, :current_status, :next_steps, :external_no, :target_build, :author, :issue_type, :title, :issue_status, :assigned_to, :issue_priority, :application_name, :project_id)
  end
end
