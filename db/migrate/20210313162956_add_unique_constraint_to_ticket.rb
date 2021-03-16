class AddUniqueConstraintToTicket < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, [:ticket_no, :project_id], unique: true
  end
end
