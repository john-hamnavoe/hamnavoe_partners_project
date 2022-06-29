class AddArchivedStepToCase < ActiveRecord::Migration[6.1]
  def change
    add_column :cases, :archived_step, :string
  end
end
