class CreateInsuranceFees < ActiveRecord::Migration
  def change
    create_table :insurance_fees do |t|
      t.integer :duration_from
      t.integer :duration_to
      t.float :percentual

      t.timestamps
    end
  end
end
