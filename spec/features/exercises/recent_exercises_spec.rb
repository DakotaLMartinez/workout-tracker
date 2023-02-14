require 'rails_helper'

feature "Creating sets adds to Current User's recent exercises" do
  before(:each) do 
    @user = create(:user)
    visit new_user_session_path 
    LoginPage.new.sign_in(@user.email, @user.password)
    @bench_press = Exercise.create(name: "Bench Press", user: @user)
    @military_press = Exercise.create(name: "Military Press", user: @user)
    @cable_crossover = Exercise.create(name: "Cable Crossover", user: @user)
    @side_lat_raise = Exercise.create(name: "Side Lateral Raise", user: @user)
    @tricep_extensions = Exercise.create(name: "Tricep Extensions", user: @user)
    @user.add_exercise(@bench_press)
    @user.add_exercise(@military_press)
    @user.add_exercise(@cable_crossover)
    @user.add_exercise(@side_lat_raise)
    @user.add_exercise(@tricep_extensions)

    @set_1 = ExerciseSet.create(user: @user, exercise: @bench_press, quantity: 10, weight: 20)
    @set_2 = ExerciseSet.create(user: @user, exercise: @military_press, quantity: 10, weight: 20)
    @set_3 = ExerciseSet.create(user: @user, exercise: @cable_crossover, quantity: 10, weight: 20)
    @set_4 = ExerciseSet.create(user: @user, exercise: @side_lat_raise, quantity: 10, weight: 20)
    @user.save!
  end

  it "Exercise Show page has links to recent exercises" do 
    visit exercise_path(@bench_press)

    expect(page).to have_link(@military_press.name)
    expect(page).to have_link(@cable_crossover.name)
    expect(page).to have_link(@side_lat_raise.name)
  end

  it "Adding a set removes stale exercises from recent exercises" do 
    @set_5 = ExerciseSet.create(user: @user, exercise: @tricep_extensions, quantity: 10, weight: 20)
    visit exercise_path(@tricep_extensions)
    # binding.pry
    expect(page).not_to have_link(@bench_press.name)

    @set_6 = ExerciseSet.create(user: @user, exercise: @bench_press, quantity: 10, weight: 20)

    visit exercise_path(@bench_press)
    expect(page).not_to have_link(@military_press.name)
  end

end