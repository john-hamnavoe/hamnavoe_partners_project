class RenameCaseIdToTicketId < ActiveRecord::Migration[6.1]
  def change
    rename_column :issues, :case_id, :ticket_id
  end
end
