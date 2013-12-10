class AddEmailIndex < ActiveRecord::Migration
  def change
      add_index :users, :emailAddress, {:name => 'email_addr_indx', :unique => true }
  end
end
