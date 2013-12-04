class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :displayName
      t.string :emailAddress
      t.integer :plan

      t.timestamps
    end
  end
end
