require 'rails_helper'

feature 'New Exercise Set' do
  before(:each) do 
    @user = FactoryGirl.create(:user)
    visit new_user_session_path 
    LoginPage.new.sign_in(@user.email, @user.password)
    @exercise = FactoryGirl.create(:exercise)
  end

  scenario 'can be seen by the user who created it', js: true do
    visit exercise_path(@exercise)
    click_link 'Add Set'
    
    fill_in 'exercise_set_quantity', with: '10'
    fill_in 'exercise_set_weight', with: '20'
    find('input[name="commit"]').click
    
    expect(page).to have_css('#set-1')
    expect(page).to have_text('10')
    expect(page).to have_text('20')
  end

  scenario 'cannot be seen by other users', js: true do 
    visit exercise_path(@exercise)
    click_link 'Add Set'
    fill_in 'exercise_set_quantity', with: '10'
    fill_in 'exercise_set_weight', with: '20'
    find('input[name="commit"]').click

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