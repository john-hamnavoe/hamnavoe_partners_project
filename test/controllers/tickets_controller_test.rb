require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user_one = users(:one)
    @ticket = tickets(:one)
  end

  test "should get index" do
    sign_in @user_one
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user_one
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    sign_in @user_one
    assert_difference('Ticket.count') do
      post tickets_url, params: { ticket: { ticket_no: @ticket.ticket_no + "uq", ticket_priority: @ticket.ticket_priority, ticket_status: @ticket.ticket_status, ticket_type: @ticket.ticket_type, project_id: @ticket.project_id, title: @ticket.title } }
    end

    assert_redirected_to tickets_url
  end

  test "should show ticket" do
    sign_in @user_one
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user_one
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    sign_in @user_one
    patch ticket_url(@ticket), params: { ticket: { ticket_no: @ticket.ticket_no, ticket_priority: @ticket.ticket_priority, ticket_status: @ticket.ticket_status, ticket_type: @ticket.ticket_type, project_id: @ticket.project_id, title: @ticket.title } }
    assert_redirected_to tickets_url
  end

  # test "should destroy ticket" do
  #   assert_difference('Ticket.count', -1) do
  #     delete ticket_url(@ticket)
  #   end

  #   assert_redirected_to tickets_url
  # end
end
