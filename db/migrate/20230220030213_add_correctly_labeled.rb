class AddCorrectlyLabeled < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :labeled_correctly, :boolean
  end
end
