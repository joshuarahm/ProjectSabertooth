class CreateDocumentPermissions < ActiveRecord::Migration
  def change
    create_table :document_permissions do |t|
      t.timestamps
      t.integer :document_id
      t.integer :user_id

      # bitmask of read,write,share
      t.integer :perms
    end
  end
end
