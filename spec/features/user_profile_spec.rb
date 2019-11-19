require 'rails_helper'

RSpec.describe 'User profile', type: :feature, js: true do
  context 'when simple user' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:first_event) { FactoryBot.create(:event, user: user, finish_date: '31/12/2018', start_date: '30/12/2018') }
    let!(:second_event) { FactoryBot.create(:event, user: user, finish_date: '01/01/2019', start_date: '28/12/2018') }
    let!(:third_event) { FactoryBot.create(:event, user: user, finish_date: '21/12/2018', start_date: '20/12/2018') }
    let!(:target_to_first_event) { FactoryBot.create(:target, event: first_event) }
    let!(:target_to_second_event) { FactoryBot.create(:target, event: second_event) }

    before do
      sign_in(user)
      visit user_path(id: user.id)
    end

    it 'show user data' do
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
      expect(page).to have_content user.phone
      expect(page).to have_content user.project.name
    end

    it 'show sorted events' do
      expected_events = [first_event.finish_date.iso8601,
                         second_event.finish_date.iso8601,
                         third_event.finish_date.iso8601].sort!.reverse
      expected_events.map! { |event| event.scan(/^\d*/).first }
      expected_events.uniq!

      expect(page).to have_content first_event.description
      expect(page).to have_content second_event.description
      expect(page).to have_content first_event.finish_date.year
      expect(page).to have_content second_event.finish_date.year

      expect(page).not_to have_content first_event.start_date
      expect(page).not_to have_content first_event.comments
      expect(page).not_to have_content first_event.summary
    end

    it 'show hidden event data when click on event header' do
      click_on_event_header(first_event)

      expect(page).to have_content first_event.comments
      expect(page).to have_content first_event.summary

      expect(page).not_to have_content second_event.comments
      expect(page).not_to have_content second_event.summary
    end

    it 'do not mark target as achieved' do
      click_on_event_header(first_event)
      click_on_target_checkbox(target_to_first_event)
      page.evaluate_script 'window.location.reload()'

      click_on_event_header(first_event)
      expect(page).not_to have_field('target' + target_to_first_event.id.to_s, checked: true)
    end
  end

  # context 'when user is admin' do
  #   let!(:admin) { FactoryBot.create(:admin) }
  #   let!(:first_event) { FactoryBot.create(:event, user: admin, finish_date: '31/12/2018', start_date: '30/12/2018') }
  #   let!(:target_to_first_event) { FactoryBot.create(:target, event: first_event) }
  #
  #   before do
  #     sign_in(admin)
  #     visit user_path(id: admin.id)
  #   end
  #
  #   it 'mark target as achieved' do
  #     click_on_event_header(first_event)
  #     click_on_target_checkbox(target_to_first_event)
  #     page.evaluate_script 'window.location.reload()'
  #
  #     click_on_event_header(first_event)
  #     expect(page).to have_field('target' + target_to_first_event.id.to_s, checked: true)
  #   end
  # end

  context 'when user/admin display other profile' do
    let!(:admin) { FactoryBot.create(:admin) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_event) { FactoryBot.create(:event, user: admin, finish_date: '31/12/2018', start_date: '30/12/2018') }
    let!(:user_event) { FactoryBot.create(:event, user: user, finish_date: '31/12/2018', start_date: '30/12/2018') }

    it 'admin show user events' do
      sign_in(admin)
      visit user_path(id: user.id)

      expect(page).to have_content user_event.description
      expect(page).to have_content user_event.finish_date.year
    end

    it 'user not show other events' do
      sign_in(user)
      visit user_path(id: admin.id)

      expect(page).not_to have_content admin_event.description
      expect(page).not_to have_content admin_event.finish_date.year
    end
  end

  private

  def click_on_event_header(event)
    find('span', text: event.description).click
  end

  def click_on_target_checkbox(target)
    find('label', text: target.description).click
  end
end
