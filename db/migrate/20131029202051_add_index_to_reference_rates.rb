class AddIndexToReferenceRates < ActiveRecord::Migration
  def change
  	add_index "reference_rates", ["name", "date"], :name => "index_reference_rates_on_name_and_date", :unique => true
  end
end
