require "application_system_test_ticket"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "creating a Case" do
    visit tickets_url
    click_on "New Case"

    fill_in "Ticket no", with: @ticket.ticket_no
    fill_in "Ticket priority", with: @ticket.ticket_priority
    fill_in "Ticket status", with: @ticket.ticket_status
    fill_in "Ticket type", with: @ticket.ticket_type
    fill_in "Issue", with: @ticket.issue_id
    fill_in "Project", with: @ticket.project_id
    fill_in "Title", with: @ticket.title
    click_on "Create Case"

    assert_text "Ticket was successfully created"
    click_on "Back"
  end

  test "updating a Case" do
    visit tickets_url
    click_on "Edit", match: :first

    fill_in "Ticket no", with: @ticket.ticket_no
    fill_in "Ticket priority", with: @ticket.ticket_priority
    fill_in "Ticket status", with: @ticket.ticket_status
    fill_in "Ticket type", with: @ticket.ticket_type
    fill_in "Issue", with: @ticket.issue_id
    fill_in "Project", with: @ticket.project_id
    fill_in "Title", with: @ticket.title
    click_on "Update Case"

    assert_text "Ticket was successfully updated"
    click_on "Back"
  end

  test "destroying a Case" do
    visit tickets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ticket was successfully destroyed"
  end
end
