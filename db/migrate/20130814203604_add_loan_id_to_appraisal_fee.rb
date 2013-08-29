class AddLoanIdToAppraisalFee < ActiveRecord::Migration
  def change
    add_column :appraisal_fees, :loan_id, :integer
  end
end
