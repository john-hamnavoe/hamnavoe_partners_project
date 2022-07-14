# frozen_string_literal: true

class TestCasesController < ApplicationController
  before_action :authenticate_user!

  # GET /cases or /cases.json
  def index
    test_cases = query_cases(query_params, {})

    @page, @pagy, @test_cases = pagy_results(test_cases)

    respond_to do |format|
      format.html
      format.xlsx
      format.json { render json: @tcases.to_json }
    end
  end

  private

  def permitted_order_columns
    %w[position department title extra assigned_to]
  end

  def query_cases(query_params, args = {})
    query = TestCase.where(args)
    query = query.where("lower(title) LIKE :keyword OR lower(notes) LIKE :keyword OR lower(extra) LIKE :keyword", keyword: "%#{query_params[:keywords].downcase}%") if query_params && query_params[:keywords]

    order_by = permitted_column_name(permitted_order_columns, session[session_symbol("order_by")])

    query.order("#{order_by} #{permitted_direction(session[session_symbol("direction")] || "asc")}")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = TestCase.find(params[:id])
  end
end
