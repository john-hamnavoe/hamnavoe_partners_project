# frozen_string_literal: true

class UpdateIssueWithCustomerStateJob < ApplicationJob
  queue_as :default

  def perform(project_id)
    issues = Issue.where(project_id: project_id)
    issues.each do |issue|
      with_us = issue.assigned_to.in?(%w[Pramod Victor Conrad HenryF])
      issue.update(with_customer: !with_us)
    end
  end
end
