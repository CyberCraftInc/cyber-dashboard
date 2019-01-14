require 'rails_helper'

describe 'Sort users', type: :feature do
  let!(:first_user) { FactoryBot.create(:user, last_name: 'bbb', first_name: 'cc') }
  let!(:second_user) { FactoryBot.create(:user, last_name: 'ccc', first_name: 'aa') }
  let!(:third_user) { FactoryBot.create(:user, last_name: 'aaa', first_name: 'bb') }

  before(:each) do
    sign_in(first_user)
  end

  it 'sort by default value', js: true do
    last_names_from_page = page.all('td.last-name-column').map(&:text)
    sorted_list_of_users = [third_user.last_name, first_user.last_name, second_user.last_name]

    expect(last_names_from_page).to eq sorted_list_of_users
  end

  it 'sort by not default value', js: true do
    click_on_first_name_head
    last_names_from_page = page.all('td.first-name-column').map(&:text)
    sorted_list_of_users = [second_user.first_name, third_user.first_name, first_user.first_name]

    expect(last_names_from_page).to eq sorted_list_of_users
  end

  it 'reverse sort by double click', js: true do
    click_on_first_name_head
    click_on_first_name_head

    last_names_from_page = page.all('td.first-name-column').map(&:text)
    sorted_list_of_users = [second_user.first_name, third_user.first_name, first_user.first_name].reverse!

    expect(last_names_from_page).to eq sorted_list_of_users
  end

  private

  def click_on_first_name_head
    page.all('thead span')[1].click
  end
end
