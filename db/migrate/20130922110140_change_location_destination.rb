class ChangeLocationDestination < ActiveRecord::Migration
  def change
  	  rename_column :histories, :location_id, :destination_id
  end
end
