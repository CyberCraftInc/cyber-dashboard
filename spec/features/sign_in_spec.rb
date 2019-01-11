require 'rails_helper'

describe 'Sign in', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    visit new_user_session_path
  end

  it 'with correct credentials', js: true do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'List of users'
  end

  it 'with incorrect credentials', js: true do
    fill_in 'Email', with: user.email
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
