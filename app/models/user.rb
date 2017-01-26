class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workouts
  has_many :workout_exercises
  has_many :user_exercises
  has_many :exercises, through: :user_exercises
  has_many :exercise_sets

  def last_sets_of_exercise(exercise, number)
    exercise_sets.where(exercise: exercise).order(created_at: 'desc').limit(Integer(number))
  end

  def last_five_sets_of_exercise(exercise)
    last_sets_of_exercise(exercise, 5)
  end

  def add_exercise(exercise)
    if !UserExercise.exists?(user: self, exercise: exercise)
      exercise.save 
      UserExercise.create(user: self, exercise: exercise)
      self.save
    end
  end

  def recent_exercises
    @recent_exercises ||= exercise_sets.order(created_at: :desc)
                                       .limit(30)
                                       .select{ |set| set.created_at > Time.zone.now() - 3.hours }
                                       .map{ |set| set.exercise}
                                       .uniq[0..3]
    # @recent_exercises ||= exercise_sets.order(created_at: :asc).only(:order).from(exercise_sets.reverse_order.limit(6), 'exercise_sets').map{|es| es.exercise}.uniq
  end

  def add_to_recent_exercises(exercise)
    unless recent_exercises.include?(exercise)
      @recent_exercises = recent_exercises[0,-2].unshift(exercise) if recent_exercises[0,-2]
    end
  end

  def recent_sets_count(exercise)
    exercise.recent_sets(self).length
  end
end
