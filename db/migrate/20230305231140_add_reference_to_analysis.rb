class AddReferenceToAnalysis < ActiveRecord::Migration[7.0]
  def change
    add_reference :analyses, :agents, null: false, foreign_key: true
  end
end
