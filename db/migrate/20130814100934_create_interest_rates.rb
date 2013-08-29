class CreateInterestRates < ActiveRecord::Migration
  def change
    create_table :interest_rates do |t|
      t.boolean :fixed
      t.integer :duration_from
      t.integer :duration_to
      t.boolean :bank_customer
      t.boolean :insured
      t.float :rate

      t.timestamps
    end
  end
end
