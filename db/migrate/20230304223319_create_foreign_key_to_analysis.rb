class CreateForeignKeyToAnalysis < ActiveRecord::Migration[7.0]
  def change
    create_table :foreign_key_to_analyses do |t|
      add_foreign_key :Analysis, :active_storage_blobs, column: "id"
    end
  end
end
