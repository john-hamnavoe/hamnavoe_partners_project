class CreateTestCases < ActiveRecord::Migration[6.1]
  def change
    create_table :test_cases do |t|
      t.references :project, null: false, foreign_key: true
      
      t.integer :position
      t.string :department
      t.string :title
      t.string :extra
      t.string :status
      t.string :assigned_to
      t.string :notes
      t.string :additional_solution

      t.timestamps
    end
  end
end
