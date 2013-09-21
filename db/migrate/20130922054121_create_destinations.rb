class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.references :hospital, index: true
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
