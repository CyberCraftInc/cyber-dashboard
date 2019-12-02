require 'rails_helper'

describe 'Dropdown header', type: :feature, js: true do
  it 'check elements of header' do
    production_admin_sign_in
    expect(page).not_to have_content 'Profile'
    expect(page).not_to have_content 'Edit profile'
    expect(page).not_to have_content 'Logout'

    find('div > div > span', text: 'Admin').click

    expect(page).to have_content 'Profile'
    expect(page).to have_content 'Edit profile'
    expect(page).to have_content 'Logout'
  end
end
