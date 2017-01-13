require 'rails_helper' 

describe User do 
  before do 
    @user = FactoryGirl.create(:user)
    @workout = @user.workouts.create(name: "Push")
    @bench_press = Exercise.create(name: "Bench Press", user: @user)
    @military_press = Exercise.create(name: "Military Press", user: @user)
    @user.add_exercise(@bench_press)
    @user.add_exercise(@military_press)

    @user.save!
  end

  it "has many workouts" do 
    expect(@user.workouts).to include(@workout)
  end

  it "has many exercises through workout_excercises" do 
    expect(@user.exercises).to include(@bench_press, @military_press)
  end
end