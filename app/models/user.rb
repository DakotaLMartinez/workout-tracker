class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workouts
  has_many :workout_exercises
  has_many :user_exercises
  has_many :exercises, through: :user_exercises
  has_many :exercise_sets, through: :exercises

  def add_exercise(exercise)
    if !UserExercise.exists?(user: self, exercise: exercise)
      exercise.save 
      UserExercise.create(user: self, exercise: exercise)
      self.save
    end
  end
end
