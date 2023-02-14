require 'rails_helper'

feature 'Authentication' do
  before do
    @user = create(:user)
    visit new_user_session_path
    @login_page = LoginPage.new
  end

  feature 'login' do
    scenario 'with valid inputs' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('Logout')
    end

    scenario 'with invalid credentials' do
      @login_page.sign_in('invalid@lol.com', 'not the actual password')
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario 'redirect after login' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('Signed in successfully')
    end
  end
end