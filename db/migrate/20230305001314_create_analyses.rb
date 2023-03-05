class CreateAnalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :analyses do |t|
      t.float "confidence"
      t.string "label"
      t.boolean "assigned", default: false
      t.boolean "correct_label"
      t.datetime "time_of_labeling"
      t.integer "blobs_id"
    end
  end
end
