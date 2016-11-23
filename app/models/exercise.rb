class Exercise < ApplicationRecord
  has_many :workout_exercises 
  has_many :workouts, through: :workout_exercises
  belongs_to :user
  has_many :user_exercises
  has_many :users, through: :user_exercises
  has_many :exercise_sets
end
