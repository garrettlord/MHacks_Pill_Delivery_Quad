class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.references :hospital, index: true
      t.string :name
      t.string :type
      t.text :description
      t.boolean :restricted
      t.integer :quantity

      t.timestamps
    end
  end
end
