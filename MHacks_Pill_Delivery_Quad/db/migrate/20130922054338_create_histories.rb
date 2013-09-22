class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :copter, index: true
      t.references :hospital, index: true
      t.references :location, index: true
      t.string :time_left
      t.string :time_delivered
      t.string :time_returned

      t.timestamps
    end
  end
end
