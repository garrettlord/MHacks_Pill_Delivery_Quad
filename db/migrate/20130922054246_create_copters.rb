class CreateCopters < ActiveRecord::Migration
  def change
    create_table :copters do |t|
      t.references :hospital, index: true
      t.string :name
      t.string :type
      t.float :last_latitude
      t.float :last_longitude
      t.boolean :available

      t.timestamps
    end
  end
end
