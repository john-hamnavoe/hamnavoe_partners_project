class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|
      t.references :project, null: false, foreign_key: true
      t.references :test_case, null: true, foreign_key: true

      t.string :case_no
      t.string :project_no
      t.string :subject
      t.string :priority
      t.string :product
      t.string :module
      t.string :status
      t.string :stage
      t.string :assigned_to

      t.boolean :tracked, default: false
      t.string :notes
      t.string :tags
      t.string :next_steps
      t.string :previous_stage
      t.string :previous_status


      t.timestamps

      t.index [:project_id, :case_no], unique: true
    end
  end
end
