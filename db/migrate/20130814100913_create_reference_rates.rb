class CreateReferenceRates < ActiveRecord::Migration
  def change
    create_table :reference_rates do |t|
      t.string :name
      t.float :rate

      t.timestamps
    end
  end
end
