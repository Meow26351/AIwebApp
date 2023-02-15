class AddToBlobs < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :confidence, :float
  end
end
