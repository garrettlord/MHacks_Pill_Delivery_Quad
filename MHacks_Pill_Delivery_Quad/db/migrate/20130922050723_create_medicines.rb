class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.references :hospital, index: true
      t.text :name
      t.text :type
      t.text :description
      t.boolean :restricted
      t.integer :quantity

      t.timestamps
    end
  end
end
