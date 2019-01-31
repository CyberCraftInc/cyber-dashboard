require 'rails_helper'

RSpec.feature 'Socialmedia login via Google', type: :feature do
  setup do
    google_oauth2_mock
  end

  context 'Sign in Google' do
    let!(:user) { create(:user, email: 'fakeemail@gmail-fake.com') }

    scenario 'show the logged user' do
      given_a_login_page
      expect(page).to have_content user.email
    end
  end

  context 'Sign up Google' do
    let!(:project) { create(:project) }

    before(:each) do
      given_a_login_page
    end

    scenario 'Sign up Google without errors' do
      when_i_successfully_sign_up
      then_i_expect_list_of_users
    end

    scenario 'Sign up get errors' do
      when_i_forgot_to_fill_some_fields
      then_i_expect_error
    end

    scenario 'Sign up after errors' do
      when_i_forgot_to_fill_some_fields
      fill_empty_fields
      then_i_expect_list_of_users
    end
  end

  context 'Check errors' do
    scenario 'no errors when use google sso' do
      google_oauth2_mock
      given_a_login_page

      expect(page).not_to have_content('Could not authenticate you from GoogleOauth2 because')
      expect(page).not_to have_content('Csrf detected')
    end

    scenario 'get error when use google sso with invalid credentials' do
      google_oauth2_invalid_mock
      given_a_login_page
      expect(page).to have_content 'Could not authenticate you from GoogleOauth2'
    end
  end

  def given_a_login_page
    visit new_user_session_path
    expect(page).to have_text('Log in')
    find('a#oauth.btn').click
  end

  def when_i_successfully_sign_up
    fill_in 'Phone', with: '+365481524500'
    select(project.name, from: 'Project')
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123123'
    click_button 'Sign up'
  end

  def when_i_forgot_to_fill_some_fields
    fill_in 'Phone', with: '+365481524500'
    click_button 'Sign up'
  end

  def fill_empty_fields
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123123'
    click_button 'Sign up'
  end

  def then_i_expect_list_of_users
    expect(page).to have_content 'List of users'
  end

  def then_i_expect_error
    expect(page).to have_content 'error prohibited this user from being saved'
  end
end
