require 'rails_helper'

describe 'Rails Admin', type: :feature do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.build(:project) }

  context 'with simple user' do
    before do
      sign_in(user)
    end

    it 'try visit admin dashboard' do
      find('span', text: user.first_name).click
      expect(page).not_to have_content('Admin')
      visit rails_admin_path
      expect do
        visit rails_admin_path
        expect(page).to have_text 'Not found'
      end.to raise_error(ActionController::RoutingError)
    end
  end

  context 'with admin user' do
    before do
      sign_in(admin)
      find('span', text: admin.first_name).click
      find('a', text: 'Admin').click
    end

    it 'visit admin dashboard' do
      expect(page).to have_content('Cyberdashboard')
      expect(page).to have_content('Site Administration')
    end

    it 'create Project' do
      find('li a', text: 'Projects').click
      find('span', text: 'Add new').click

      fill_in 'Name', with: project.name
      fill_in 'Desc', with: project.desc
      find('button.btn-primary', text: 'Save').click
      expect(page).to have_content 'Project successfully created'
    end
  end
end
