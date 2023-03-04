class RemoveUserIdFromWorkoutExercises < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:workout_exercises, :user, index: true, foreign_key: true)
  end
end
