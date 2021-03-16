class AddWithCustomerToIssue < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :with_customer, :boolean, default: true
  end
end
