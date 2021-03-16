require "test_helper"

class IssuesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user_one = users(:one)
    @issue = issues(:one)
  end

  test "should get index" do
    sign_in @user_one
    get issues_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user_one
    get new_issue_url
    assert_response :success
  end

  test "should create issue" do
    sign_in @user_one
    assert_difference('Issue.count') do
      post issues_url, params: { issue: { application_name: @issue.application_name, assigned_to: @issue.assigned_to, author: @issue.author, external_no: @issue.external_no, issue_no: @issue.issue_no + "uq", issue_priority: @issue.issue_priority, issue_status: @issue.issue_status, issue_type: @issue.issue_type, project_id: @issue.project_id, target_build: @issue.target_build, title: @issue.title } }
    end

    assert_redirected_to issues_url
  end

  test "should show issue" do
    sign_in @user_one
    get issue_url(@issue)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user_one
    get edit_issue_url(@issue)
    assert_response :success
  end

  test "should update issue" do
    sign_in @user_one
    patch issue_url(@issue), params: { issue: { application_name: @issue.application_name, assigned_to: @issue.assigned_to, author: @issue.author, external_no: @issue.external_no, issue_no: @issue.issue_no, issue_priority: @issue.issue_priority, issue_status: @issue.issue_status, issue_type: @issue.issue_type, project_id: @issue.project_id, target_build: @issue.target_build, title: @issue.title } }
    assert_redirected_to issues_url
  end

  test "should destroy issue" do
    sign_in @user_one
    assert_difference('Issue.count', -1) do
      delete issue_url(@issue)
    end

    assert_redirected_to issues_url
  end
end
