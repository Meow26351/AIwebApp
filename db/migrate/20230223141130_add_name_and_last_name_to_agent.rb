class AddNameAndLastNameToAgent < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :name, :string
    add_column :agents, :last_name, :string
    add_column :agents, :admin, :boolean, :default => false
  end
end
