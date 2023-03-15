class RemoveColumnFromBlob < ActiveRecord::Migration[7.0]
  def change
    remove_columns :active_storage_blobs, :confidence, :label, :labeled_correctly, :assigned
  end
end
