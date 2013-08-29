class AddLoanIdToInsuranceFee < ActiveRecord::Migration
  def change
    add_column :insurance_fees, :loan_id, :integer
  end
end
