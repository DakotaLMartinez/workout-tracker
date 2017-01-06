class Exercise < ApplicationRecord
  has_many :workout_exercises 
  has_many :workouts, through: :workout_exercises
  belongs_to :user
  has_many :user_exercises
  has_many :users, through: :user_exercises
  has_many :exercise_sets

  def add_to_workout(workout, user)
    we = WorkoutExercise.new(workout: workout, user: user, exercise: self)
    if we.valid?
      we.save 
      workout.save
      user.save
      self.save
    end
  end

  def recent_sets(user)
    @recent_sets ||= exercise_sets.where(user: user, created_at: (Time.zone.now - 3.hours)..Time.zone.now)
  end
end
