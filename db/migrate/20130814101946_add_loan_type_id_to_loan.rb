class AddLoanTypeIdToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :loan_type_id, :integer
  end
end
