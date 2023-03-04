require 'rails_helper'

feature 'Creating New Exercises' do
  before(:each) do 
    @user = create(:user)
    visit new_user_session_path 
    LoginPage.new.sign_in(@user.email, @user.password)
  end

  # scenario 'User creates a new Exercise' do
  #   visit new_exercise_path
  #   fill_in 'exercise_name', with: 'My New Exercise'
  #   click_button 'Submit'
  #   expect(page).to have_text('My New Exercise')
  # end

  scenario "User edits the exercises present in a workout" do 
    @user.exercises.create(name: "Bicep Curl")
    @user.exercises.create(name: "Tricep Curl")
    workout = @user.workouts.create(name: "Arms")
    expect(workout.exercises.length).to eq(0)
    visit edit_workout_path(workout)
    check "Bicep Curl"
    check "Tricep Curl"
    click_button "Submit"
    
    workout.reload
    expect(workout.exercises.length).to eq(2)
  
  end
end