class AddLabelToBlobs < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :label, :string
  end
end
