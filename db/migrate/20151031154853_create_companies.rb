class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :earnings
      t.integer :nesting_level
      t.integer :master_company_id

      t.timestamps
    end
  end
end
