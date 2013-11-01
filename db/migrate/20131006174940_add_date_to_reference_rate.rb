class AddDateToReferenceRate < ActiveRecord::Migration
  def change
    add_column :reference_rates, :date, :date
  end
end
