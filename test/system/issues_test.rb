require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:one)
  end

  test "visiting the index" do
    visit issues_url
    assert_selector "h1", text: "Issues"
  end

  test "creating a Issue" do
    visit issues_url
    click_on "New Issue"

    fill_in "Application name", with: @issue.application_name
    fill_in "Assigned to", with: @issue.assigned_to
    fill_in "Author", with: @issue.author
    fill_in "External no", with: @issue.external_no
    fill_in "Issue no", with: @issue.issue_no
    fill_in "Issue priority", with: @issue.issue_priority
    fill_in "Issue status", with: @issue.issue_status
    fill_in "Issue type", with: @issue.issue_type
    fill_in "Project", with: @issue.project_id
    fill_in "Target build", with: @issue.target_build
    fill_in "Title", with: @issue.title
    click_on "Create Issue"

    assert_text "Issue was successfully created"
    click_on "Back"
  end

  test "updating a Issue" do
    visit issues_url
    click_on "Edit", match: :first

    fill_in "Application name", with: @issue.application_name
    fill_in "Assigned to", with: @issue.assigned_to
    fill_in "Author", with: @issue.author
    fill_in "External no", with: @issue.external_no
    fill_in "Issue no", with: @issue.issue_no
    fill_in "Issue priority", with: @issue.issue_priority
    fill_in "Issue status", with: @issue.issue_status
    fill_in "Issue type", with: @issue.issue_type
    fill_in "Project", with: @issue.project_id
    fill_in "Target build", with: @issue.target_build
    fill_in "Title", with: @issue.title
    click_on "Update Issue"

    assert_text "Issue was successfully updated"
    click_on "Back"
  end

  test "destroying a Issue" do
    visit issues_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Issue was successfully destroyed"
  end
end
