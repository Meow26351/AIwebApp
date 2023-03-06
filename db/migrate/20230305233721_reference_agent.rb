class ReferenceAgent < ActiveRecord::Migration[7.0]
  def change
    add_reference :analyses, :agents, foreign_key: true
  end
end
