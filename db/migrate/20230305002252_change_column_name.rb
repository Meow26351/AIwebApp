class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :analyses , :blobs_id, :blob_id
  end
end
