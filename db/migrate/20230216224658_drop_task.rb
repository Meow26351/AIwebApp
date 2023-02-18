class DropTask < ActiveRecord::Migration[7.0]
  def change
    remove_column :agents, :tasks_id
    drop_table :active_storage_attachments
    drop_table :active_storage_variant_records
    drop_table :active_storage_blobs
    drop_table :tasks
  end
end
