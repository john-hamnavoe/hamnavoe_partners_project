# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets or /tickets.json
  def index
    tickets = query_tickets(query_params, {}, permitted_column_name(permitted_order_columns, session[session_symbol("order_by")]), permitted_direction(session[session_symbol("direction")]))
    @page, @pagy, @tickets = pagy_results(tickets)

    respond_to do |format|
      format.html
      format.json { render json: @tickets.to_json }
    end
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @issues = Issue.where(issue_type: %w[Issue Defect], issue_priority: %w[2-high 1-showstopper]).order("issue_no::integer ASC")
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to tickets_path, notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to tickets_path, notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    @project = Project.first

    @import_errors = []
    spreadsheet = Roo::Spreadsheet.open(params[:file].path)
    @import_data = []
    spreadsheet.each(ticket_no: "ID",
                     title: "Title",
                     ticket_status: "Request Status",
                     ticket_type: "Category",
                     ticket_priority: "Priority",
                     ticket_reason: "Requestor",
                     target_branch: "Target Release") do |hash|
      @import_data << hash.merge(project_id: @project.id)
    end

    Ticket.import @import_data, on_duplicate_key_update: { conflict_target: [:ticket_no, :project_id], columns: [:title, :ticket_status, :ticket_type, :ticket_priority, :ticket_reason, :target_branch] }, returning: :ticket_no
    import_with_id = Ticket.find_by(ticket_no: "ID")
    import_with_id&.destroy
    AssignTicketToIssueJob.perform_async(@project.id)
    redirect_to tickets_path, notice: "Tickets imported and are being matched to issues!"
  end

  private

  def permitted_order_columns
    %w[ticket_no title]
  end

  def query_tickets(query_params, args = {}, order_by = "ticket_no", direction = "desc")
    query = Ticket.where(args)
    query = query.where("lower(ticket_no) LIKE :keyword OR lower(title) LIKE :keyword", keyword: "%#{query_params[:keywords].downcase}%") if query_params && query_params[:keywords]
    query.order(order_by => direction)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:issue_id, :ticket_id, :ticket_no, :title, :ticket_status, :ticket_type, :ticket_priority, :project_id)
  end
end
