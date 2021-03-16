class AddCurrentStatusNextStepsToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :current_status, :text
    add_column :issues, :next_steps, :text
  end
end
