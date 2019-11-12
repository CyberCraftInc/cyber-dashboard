require 'rails_helper'

RSpec.describe 'Header dropdown list', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it 'profile text absent' do
    expect(page).not_to have_content 'Profile'
    expect(page).not_to have_content 'Edit profile'
    expect(page).not_to have_content 'Logout'
  end

  it 'profile dropdown links list' do
    find('span', text: user.first_name).click

    expect(page).to have_content 'Profile'
    expect(page).to have_content 'Edit profile'
    expect(page).to have_content 'Logout'
  end

  it 'visit own page from dropdown link' do
    find('span', text: user.first_name).click
    find('a', text: 'Profile').click

    expect(page).to have_current_path(user_path(user))
  end
end
