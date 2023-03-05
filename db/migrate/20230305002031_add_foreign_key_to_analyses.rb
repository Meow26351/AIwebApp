class AddForeignKeyToAnalyses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :analyses, :active_storage_blobs, column: "blobs_id"
  end
end
