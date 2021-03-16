# frozen_string_literal: true

class AssignTicketToIssueJob < ApplicationJob
  queue_as :default

  def perform(project_id)
    issues = Issue.where(project_id: project_id)
    issues.each do |issue|
      tfs_ticket = Ticket.find_by(ticket_no: issue.external_no.tr("^0-9", ""))
      issue.update(ticket: tfs_ticket) && next if tfs_ticket

      net_ticket = Ticket.find_by(ticket_no: issue.external_no)
      issue.update(ticket: net_ticket) if net_ticket
    end
  end
end
