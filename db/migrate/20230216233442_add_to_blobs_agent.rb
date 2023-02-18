class AddToBlobsAgent < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :confidence, :float
    add_column :active_storage_blobs, :label, :string
  end
end
