class AddTasksToAgent < ActiveRecord::Migration[7.0]
  def change
    add_reference :agents, :tasks, foreign_key: true
  end
end
