class CreateUserExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :user_exercises do |t|
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true
      t.timestamps
    end
  end
end
