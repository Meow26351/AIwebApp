class DropTableAnalysis < ActiveRecord::Migration[7.0]
  def change
    drop_table :Analysis
    drop_table :foreign_key_to_analyses
  end
end
