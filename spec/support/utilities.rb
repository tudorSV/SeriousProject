include ApplicationHelper

def sign_in(user)
  visit new_session_path
  fill_in 'Username', with: user.username
  fill_in 'Password', with: user.password
  click_button 'Login'
end
