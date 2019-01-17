require 'rails_helper'

RSpec.feature 'Header dropdown list', type: :feature do
  let(:user) { create(:user) }

  before(:each) do
    sign_in(user)
  end

  scenario 'profile text absent' do
    expect(page).to_not have_content 'Profile'
    expect(page).to_not have_content 'Edit profile'
    expect(page).to_not have_content 'Logout'
  end

  scenario 'profile dropdown links list' do
    find('span', text: user.first_name).click

    expect(page).to have_content 'Profile'
    expect(page).to have_content 'Edit profile'
    expect(page).to have_content 'Logout'
  end
end
