class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.text :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
