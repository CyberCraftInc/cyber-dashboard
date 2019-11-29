def login_user(user)
  @request.env['devise.mapping'] = Devise.mappings[user]
  sign_in user
end

def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

def production_admin_sign_in
  visit 'https://cyber-dashboard.herokuapp.com'
  fill_in 'Email', with: Rails.application.credentials.admin_production[:email]
  fill_in 'Password', with: Rails.application.credentials.admin_production[:password]
  click_button 'Log in'
end
