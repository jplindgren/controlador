def sign_in(user, options = {})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit new_user_session_path
  	fill_in "user_email", with: user.email
  	fill_in "user_password", with: user.password
  	click_button "Sign in"
  end
end