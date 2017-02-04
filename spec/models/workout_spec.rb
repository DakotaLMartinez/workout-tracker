require 'rails_helper' 

describe Workout do 
  before do 
    @user = FactoryGirl.create(:user)
    @workout = @user.workouts.create(name: "Push")
    @bench_press = @user.exercises.create(name: "Bench Press")
    @military_press = @user.exercises.create(name: "Military Press")
    WorkoutExercise.create(user: @user, workout: @workout, exercise: @bench_press)
    WorkoutExercise.create(user: @user, workout: @workout, exercise: @military_press)
    @user.save!
  end

  it "belongs to a user" do 
    expect(@workout.user).to eq(@user)
  end

  it "has a name" do 
    expect(@workout.name).to eq("Push")
  end

  it "has many exercises" do 
    expect(@workout.exercises).to include(@bench_press)
    expect(@workout.exercises).to include(@military_press)
  end

end 