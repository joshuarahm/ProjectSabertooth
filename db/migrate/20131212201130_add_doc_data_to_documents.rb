class AddDocDataToDocuments < ActiveRecord::Migration
  def change
	  add_column :documents, :content, :binary, :limit => 10.megabyte
  end
end
