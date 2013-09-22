class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :copter, index: true
      t.references :hospital, index: true
      t.references :destination, index: true
      t.text :time_left
      t.text :time_delivered
      t.text :time_returned

      t.timestamps
    end
  end
end
