class CreateCopters < ActiveRecord::Migration
  def change
    create_table :copters do |t|
      t.references :hospital, index: true
      t.text :name
      t.text :type
      t.float :last_latitude
      t.float :last_longitude
      t.boolean :available

      t.timestamps
    end
  end
end
