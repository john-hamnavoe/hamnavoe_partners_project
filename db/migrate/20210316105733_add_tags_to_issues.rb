class AddTagsToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :tags, :string
  end
end
