class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.timestamps
      t.integer :owner_id
      t.string :name
    end
  end
end
