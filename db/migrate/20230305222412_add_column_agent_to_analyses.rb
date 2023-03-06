class AddColumnAgentToAnalyses < ActiveRecord::Migration[7.0]
  def change
    add_column :analyses, :agent_id, :integer
    add_foreign_key :analyses, :agents, column: 'agent_id'
  end
end
