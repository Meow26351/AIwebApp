class DropColumnAgent < ActiveRecord::Migration[7.0]
  def change
    remove_column :analyses, :agent_id
  end
end
