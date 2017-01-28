require 'rails_helper'

RSpec.feature 'New Exercise Set', :type => :feature do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    visit new_user_session_path 
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    find('input[name="commit"]').click
    
    visit new_exercise_path
    fill_in 'exercise_name', with: 'Bench Press'
    find('input[name="commit"]').click

    visit 'exercises/1'
  end

  scenario 'can be seen by the user who created it', js: true do
    click_link 'Add Set'
    within('.new_exercise_set') do 
      fill_in 'exercise_set_quantity', with: '10'
      fill_in 'exercise_set_weight', with: '20'
      find('input[name="commit"]').click
    end

    expect(page).to have_css('#set-1')
    expect(page).to have_text('10')
    expect(page).to have_text('20')
  end

  scenario 'cannot be seen by other users', js: true do 
    click_link 'Add Set'
    within('.new_exercise_set') do 
      fill_in 'exercise_set_quantity', with: '10'
      fill_in 'exercise_set_weight', with: '20'
      find('input[name="commit"]').click
    end

    click_link 'Logout'
    @other_user = FactoryGirl.create(:other_user)
    visit new_user_session_path 
    fill_in 'user_email', with: @other_user.email
    fill_in 'user_password', with: @other_user.password
    find('input[name="commit"]').click

    visit 'exercises/1'

    expect(page).not_to have_css('#set-1')
    expect(page).not_to have_text('10')
    expect(page).not_to have_text('20')
  end
end