class CreateTimeEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :time_entries do |t|
      t.references :timesheet, null: false, foreign_key: true
      t.string :description
      t.float :hours

      t.timestamps
    end
  end
end
