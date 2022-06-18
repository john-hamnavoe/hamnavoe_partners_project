class CreateTaxJurisdictionPostalCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :tax_jurisdiction_postal_codes do |t|
      t.string :tax_jurisdiction
      t.string :postal_code
      t.integer :state_id

      t.timestamps
    end
  end
end
