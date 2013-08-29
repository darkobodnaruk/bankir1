class AddBankIdToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :bank_id, :integer
  end
end
