class LoginPage
  include Capybara::DSL

  def sign_in(email, password)
    fill_in '${user_email}', with: email
    fill_in '${user_password}', with: password
    find('input[name="commit"]').click
  end
end