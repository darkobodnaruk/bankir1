class AddReferenceRateToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :reference_rate, :text
  end
end
