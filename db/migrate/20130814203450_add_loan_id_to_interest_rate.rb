class AddLoanIdToInterestRate < ActiveRecord::Migration
  def change
    add_column :interest_rates, :loan_id, :integer
  end
end
