class RenameTypeUsers < ActiveRecord::Migration
  def change
    rename_column :users, :type, :priveledge
    rename_column :medicines, :type, :category
    rename_column :copters, :type, :category
  end
end
