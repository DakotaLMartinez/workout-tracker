require 'rails_helper'

feature 'Creating New Exercises' do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    visit new_user_session_path 
    LoginPage.new.sign_in(@user.email, @user.password)
  end

  scenario 'User creates a new Exercises' do
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
    visit new_exercise_path 
    fill_in 'exercise_name', with: 'My Second Exercise'
    find('#workout_id').find(:option, workout.name).select_option
    click_button 'Submit'

    visit workout_path(workout)
    expect(page).to have_text('My Second Exercise') 
  end
end