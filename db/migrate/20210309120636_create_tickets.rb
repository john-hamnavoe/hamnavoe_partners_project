class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_no
      t.string :title
      t.string :ticket_status
      t.string :ticket_type
      t.string :ticket_priority
      t.string :ticket_reason
      t.string :target_branch
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
