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
      project: project.name,
      position: 'position',
      birthday: Time.zone.today,
      start_in_company: Time.zone.today
    }
  end

  before do
    visit new_user_registration_path
  end

  it 'with correct filled form', js: true do
    expect(find_field('Position').value).to eq 'Engineer'
    expect(find_field('Start in company').value).to eq Time.current.strftime('%Y-%m-%d')

    fill_in_sign_up_form
    click_button 'Sign up'

    expect(page).to have_content 'Number of employees'
  end

  it 'with incorrect phone number format' do
    fill_in_sign_up_form(phone: '1234567')
    click_button 'Sign up'

    expect(page).to have_content 'Phone should be in +380XXXXXXXXX format'
    expect(page).not_to have_content 'List of users'
  end

  it 'with missed email field', js: true do
    fill_in_sign_up_form(email: nil)
    click_button 'Sign up'

    expect(page).to have_content 'Email can\'t be blank'
    expect(page).not_to have_content 'Number of employees'
  end

  it 'sends the confirmation email' do
    expect do
      fill_in_sign_up_form(email: 'uniqemail@g.com')
      click_button 'Sign up'
    end.to change { ActionMailer::Base.deliveries.count }.by(1)

    confirmation_email = Devise.mailer.deliveries.last

    expect(confirmation_email.to[0]).to eq 'uniqemail@g.com'
    expect(confirmation_email.body.encoded).to include 'You can confirm your account email through the link below:'
  end

  it 'confirms email by link' do
    include ActionView::Helpers
    fill_in_sign_up_form(email: 'uniqemail@g.com')
    click_button 'Sign up'

    user = User.find_by(email: 'uniqemail@g.com')

    expect do
      visit user_confirmation_path(confirmation_token: user.confirmation_token)
    end.to change { user.reload.confirmed? }.from(false).to(true)
  end

  private

  def fill_in_sign_up_form(default_options = {})
    options = sign_in_params.merge(default_options)
    fill_in 'First name', with: options[:first_name]
    fill_in 'Last name', with: options[:last_name]
    fill_in 'Phone', with: options[:phone]
    fill_in 'Email', with: options[:email]
    fill_in 'Password', with: options[:password]
    fill_in 'Confirm password', with: options[:password]
    fill_in 'Birthday', with: options[:birthday]
    find('select option:first-of-type').select_option
  end
end
