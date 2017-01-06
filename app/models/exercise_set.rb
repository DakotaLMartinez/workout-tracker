class ExerciseSet < ApplicationRecord
  belongs_to :user 
  belongs_to :exercise 

  after_save :add_to_users_recent_exercises

  def add_to_users_recent_exercises
    user.add_to_recent_exercises(exercise)
  end
end
