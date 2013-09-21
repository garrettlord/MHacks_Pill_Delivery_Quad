class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, index: true
      t.references :hospital, index: true
      t.references :destination, index: true
      t.string :time_requested

      t.timestamps
    end
  end
end
