require 'rails_helper'

RSpec.describe 'Create & edit event', type: :feature, js: true do
  context 'when user is simple user' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event, user: user) }

    before do
      sign_in(user)
      visit user_path(id: user.id)
    end

    it 'not display create event button' do
      expect(page).not_to have_content 'Create event'
    end
  end

  context 'when user is admin' do
    let!(:admin) { FactoryBot.create(:admin) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event, user: user) }

    before do
      sign_in(admin)
      visit user_path(id: user.id)
    end

    it 'display create event button' do
      expect(page).to have_content 'Create event'
    end

    it 'create event with valid data' do
      click_button 'Create event'

      fill_in 'Description', with: 'My event description'
      fill_in 'Start date', with: Time.current
      fill_in 'Finish date', with: Time.current + (30 * 60 * 60 * 24)
      fill_in 'add-new-target', with: 'First target'
      click_create_target
      fill_in 'add-new-target', with: 'Second target'
      click_create_target
      click_button 'Submit'

      click_on_event_header('My event description')

      expect(page).to have_content 'My event description'
      expect(page).to have_content 'First target'
      expect(page).to have_content 'Second target'
    end

    it 'failed create event with not valid data' do
      click_button 'Create event'

      fill_in 'Description', with: 'My event description'
      fill_in 'Start date', with: Time.current
      click_button 'Submit'

      expect(page).to have_content 'can\'t be blank'
    end

    it 'failed create target without description' do
      click_button 'Create event'
      click_create_target

      expect(page).to have_content 'Field can\'t be blank'
    end

    it 'edit event' do
      click_edit_event(event.id)

      expect(page).to have_content event.description

      fill_in 'Description', with: 'New description'
      click_button 'Submit'

      expect(page).not_to have_content event.description
      expect(page).to have_content 'New description'
    end
  end

  private

  def click_on_event_header(event_description)
    find('span', text: event_description).click
  end

  def click_edit_event(event_id)
    find('#edit-event' + event_id.to_s).click
  end

  def click_create_target
    find('#create-target').click
  end
end
