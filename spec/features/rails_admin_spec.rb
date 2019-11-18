require 'rails_helper'

describe 'Rails Admin', type: :feature do
  let(:user) { create(:admin) }

  before do
    sign_in(user)
  end

  it 'with admin user', js: true do
    find('span', text: user.first_name).click
    find('a', text: 'Admin').click

    expect(page).to have_content('Cyberdashboard')
    expect(page).to have_content('Site Administration')
  end
end
