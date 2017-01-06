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

  def recent_exercises
    @recent_exercises ||= exercise_sets.select{ |es| es.created_at > Time.zone.now() - 3.hours }.map{ |es| es.exercise}.uniq[0..3]
    puts @recent_exercises
    @recent_exercises
  end

  def add_to_recent_exercises(exercise)
    @recent_exercises = recent_exercises.unshift(exercise) if !recent_exercises.include?(exercise)
  end
end
