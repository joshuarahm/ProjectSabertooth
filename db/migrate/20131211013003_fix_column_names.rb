class FixColumnNames < ActiveRecord::Migration
  def change
	  rename_column :users, :displayName, :display_name
	  rename_column :users, :emailAddress, :email_address
  end
end
