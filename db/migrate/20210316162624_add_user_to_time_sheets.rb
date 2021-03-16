class AddUserToTimeSheets < ActiveRecord::Migration[6.1]
  def change
    add_reference :timesheets, :user, null: false, foreign_key: true
  end
end
