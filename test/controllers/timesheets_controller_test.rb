require "test_helper"

class TimesheetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user_one = users(:one)
    @timesheet = timesheets(:one)
  end

  test "should get index" do
    sign_in @user_one
    get timesheets_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user_one
    get new_timesheet_url
    assert_response :success
  end

  test "should create timesheet" do
    sign_in @user_one
    assert_difference('Timesheet.count') do
      post timesheets_url, params: { timesheet: { end: @timesheet.end, start: @timesheet.start } }
    end

    assert_redirected_to timesheets_url
  end

  test "should show timesheet" do
    sign_in @user_one
    get timesheet_url(@timesheet)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user_one
    get edit_timesheet_url(@timesheet)
    assert_response :success
  end

  test "should update timesheet" do
    sign_in @user_one
    patch timesheet_url(@timesheet), params: { timesheet: { end: @timesheet.end, start: @timesheet.start } }
    assert_redirected_to timesheets_url
  end

  # test "should destroy timesheet" do
  #   assert_difference('Timesheet.count', -1) do
  #     delete timesheet_url(@timesheet)
  #   end

  #   assert_redirected_to timesheets_url
  # end
end
