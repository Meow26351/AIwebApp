class AddSignedToBlobs < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :assigned, :boolean, :default => false
  end
end
