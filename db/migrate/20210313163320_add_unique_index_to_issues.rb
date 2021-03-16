class AddUniqueIndexToIssues < ActiveRecord::Migration[6.1]
  def change
    add_index :issues, [:issue_no, :project_id], unique: true
  end
end
