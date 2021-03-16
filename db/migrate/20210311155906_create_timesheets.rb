class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
