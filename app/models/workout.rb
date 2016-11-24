class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises 
  has_many :exercises, through: :workout_exercises

  def self.find_by_name(name, user) 
    self.where(user: user).find_by(name: name)
  end
end
