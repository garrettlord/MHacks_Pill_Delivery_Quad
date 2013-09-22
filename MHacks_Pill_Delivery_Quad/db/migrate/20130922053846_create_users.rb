class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :hospital, index: true
      t.string :name
      t.string :phone_number
      t.integer :type

      t.timestamps
    end
  end
end
