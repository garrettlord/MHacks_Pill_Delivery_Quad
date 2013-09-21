class CreateRequestedMedicines < ActiveRecord::Migration
  def change
    create_table :requested_medicines do |t|
      t.references :request, index: true
      t.references :medicine, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
