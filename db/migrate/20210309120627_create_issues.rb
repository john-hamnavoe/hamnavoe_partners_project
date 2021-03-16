class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :issue_no
      t.string :external_no
      t.string :target_build
      t.string :author
      t.string :issue_type
      t.string :title
      t.string :issue_status
      t.string :assigned_to
      t.string :issue_priority
      t.string :application_name
      t.string :notes
      t.references :project, null: false, foreign_key: true


      t.timestamps
    end
  end
end
