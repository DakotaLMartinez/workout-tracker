require 'rails_helper'

feature 'Creating New Exercises' do
  before(:each) do 
    @user = create(:user)
    visit new_user_session_path 
    LoginPage.new.sign_in(@user.email, @user.password)
  end

  scenario 'User creates a new Exercise' do
    visit new_exercise_path
    fill_in 'exercise_name', with: 'My New Exercise'
    click_button 'Submit'
    expect(page).to have_text('My New Exercise')
  end

  scenario 'User creates a new Exercise with a description', js:true do 
    visit new_exercise_path
    fill_in 'exercise_name', with: 'My Awesome Exercise'
    fill_in 'exercise_description', with: 'The best exercise ever'
    click_button 'Submit' 
    
    visit exercise_path(Exercise.last)
    click_link 'Show Details'
    expect(page).to have_content('The best exercise ever')
  end

  scenario 'User creates a new Exercise and assigns it to a workout' do 
    workout = @user.workouts.create(name: "My New Workout")
    @user.exercises.create(name: "Bicep Curls")
    @user.exercises.create(name: "Tricep Curls")
    visit new_exercise_path 
    fill_in 'exercise_name', with: 'My Second Exercise'
    check "My New Workout"
    click_button 'Submit'
    
    visit workout_path(workout)
    expect(page).to have_text('My Second Exercise') 
    expect(Exercise.last.workouts).to include(workout)
  end
end