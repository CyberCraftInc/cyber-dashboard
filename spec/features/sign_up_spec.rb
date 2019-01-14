require 'rails_helper'

describe 'Sign up', type: :feature do
  let!(:project) { FactoryBot.create(:project) }
  let(:sign_in_params) do
    {
      email: 'example@test.com',
      last_name: 'Test',
      first_name: 'test',
      phone: '380000000000',
      password: 'secret',
      project: project.name
    }
  end

  before(:each) do
    visit new_user_registration_path
  end

  it 'with correct filled form', js: true do
    fill_in_sign_up_form
    click_button 'Sign up'

    expect(page).to have_content 'List of users'
  end

  it 'with missed email field', js: true do
    fill_in_sign_up_form(email: nil)
    click_button 'Sign up'

    expect(page).to_not have_content 'List of users'
    expect(page).to have_content '1 error prohibited this user from being saved:'
  end

  private

  def fill_in_sign_up_form(default_options = {})
    options = sign_in_params.merge(default_options)
    fill_in 'First name', with: options[:first_name]
    fill_in 'Last name', with: options[:last_name]
    fill_in 'Phone', with: options[:phone]
    fill_in 'Email', with: options[:email]
    fill_in 'Password', with: options[:password]
    fill_in 'Password confirmation', with: options[:password]
    select options[:project], from: 'Project'
  end
end