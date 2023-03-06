class DropColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :analyses, :blob_id
    add_reference :analyses, :blob, foreign_key: { to_table: :active_storage_blobs }, null: false
  end
end
