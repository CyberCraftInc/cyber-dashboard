require 'rails_helper'

describe 'Edit user', type: :feature, js: true do
  it 'without password' do
    production_admin_sign_in
    find('span', text: 'Admin').click
    find('li > a', text: 'Edit profile', visible: false).click

    expect(page).to have_content 'Profile information'
    find('button#button-edit').click
    expect(page).to have_content('Current password can\'t be blank')
  end

  it 'with incorrect password' do
    production_admin_sign_in
    find('span', text: 'Admin').click
    find('li > a', text: 'Edit profile', visible: false).click

    expect(page).to have_content 'Profile information'

    fill_in 'Current password', with: 'Incorrect password'
    find('button#button-edit').click
    expect(page).to have_content('Current password is invalid')
  end

  it 'with correct password and redirect' do
    production_admin_sign_in
    find('div > div > span', text: 'Admin').click
    find('li > a', text: 'Edit profile', visible: false).click

    expect(page).to have_content 'Profile information'

    fill_in 'Current password', with: Rails.application.credentials.admin_production[:password]
    find('button#button-edit').click
    expect(page).to have_content('Profile updated. You will be redirected in 3 seconds')
    sleep(3)
    expect(page).to have_content 'Number of employees'
  end
end
