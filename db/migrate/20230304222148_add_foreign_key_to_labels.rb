class AddForeignKeyToLabels < ActiveRecord::Migration[7.0]
  def change
    add_column :Analysis, :blobs_id, :integer
  end
end
