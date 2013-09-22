class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :hospital, index: true
      t.text :name
      t.text :phone_number
      t.integer :type

      t.timestamps
    end
  end
end
