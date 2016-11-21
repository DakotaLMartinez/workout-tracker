require 'rails_helper' 

describe Workout do 
  before do 
    @user = FactoryGirl.build(:user)
    @workout = @user.workouts.build(name: "Bench Press")
  end

  it "belongs to a user" do 
    expect(@workout.user).to eq(@user)
  end

  it "has a name" do 
    expect(@workout.name).to eq("Bench Press")
  end

end 