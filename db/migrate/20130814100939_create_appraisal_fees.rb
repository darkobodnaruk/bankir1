class CreateAppraisalFees < ActiveRecord::Migration
  def change
    create_table :appraisal_fees do |t|
      t.integer :duration_from
      t.integer :duration_to
      t.float :percentual
      t.float :fixed_min
      t.float :fixed_max

      t.timestamps
    end
  end
end
