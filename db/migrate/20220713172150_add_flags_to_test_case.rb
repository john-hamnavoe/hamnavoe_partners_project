class AddFlagsToTestCase < ActiveRecord::Migration[6.1]
  def change
    add_column :test_cases, :volume_test_required, :boolean, default: false
    add_column :test_cases, :volume_per_month, :integer
    add_column :test_cases, :tests_executed, :boolean, default: false
    add_column :test_cases, :volume_tests_executed, :boolean, default: false
  end
end
