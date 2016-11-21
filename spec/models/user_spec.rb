require 'rails_helper' 

describe User do 
  before do 
    @user = FactoryGirl.create(:user)
    @workout = @user.workouts.create(name: "Push")
    @bench_press = Exercise.create(name: "Bench Press")
    @military_press = Exercise.create(name: "Military Press")
    WorkoutExercise.create(user: @user, workout: @workout, exercise: @bench_press)
    WorkoutExercise.create(user: @user, workout: @workout, exercise: @military_press)
    @user.save!
  end

  it "has many workouts" do 
    expect(@user.workouts).to include(@workout)
  end

  it "has many exercises through workout_excercises" do 
    expect(@user.exercises).to include(@bench_press)
  end
end