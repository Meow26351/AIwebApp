class RemoveNullFalse < ActiveRecord::Migration[7.0]
  def change
    remove_column :analyses, :agents_id
  end
end
