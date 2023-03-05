class CreateTableLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :Analysis do |t|
      t.float "confidence"
      t.string "label"
      t.boolean "assigned", default: false
      t.boolean "correct_label"
      t.datetime "time_of_labeling"
    end
  end
end
