class CreateLoanTypes < ActiveRecord::Migration
  def change
    create_table :loan_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
