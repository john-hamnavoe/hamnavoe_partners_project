# frozen_string_literal: true

class TicketSearchReflex < ApplicationReflex
  def perform(query = "")
    return unless query.size > 2

    @tickets = Ticket.where("lower(ticket_no) LIKE :keyword OR lower(title) LIKE :keyword", keyword: "%#{query.downcase}%").order(:ticket_no)
  end
end
