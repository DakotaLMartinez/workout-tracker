class CreateExerciseSets < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_sets do |t|
      t.references :user, foreign_key: true, null: false
      t.references :exercise, foreign_key: true, null: false
      t.integer :quantity, required: true, null: false
      t.integer :weight, required: true, null: false
      t.timestamps
    end
  end
end
