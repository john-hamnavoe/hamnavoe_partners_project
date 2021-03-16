class AddTicketToIssue < ActiveRecord::Migration[6.1]
  def change
    add_reference :issues, :ticket, null: true, foreign_key: true
  end
end
