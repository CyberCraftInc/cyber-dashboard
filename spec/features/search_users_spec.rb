require 'rails_helper'

RSpec.describe 'Search users', type: :feature do
  let(:users) { create_list(:user, 5) }

  before do
    given_page_list_of_users_with_logged_user
  end

  it 'Fill search by first name' do
    when_i_fill_search_field_with('Joh')
    then_i_expect_to_see_list_of_users_by('first_name', search_text)
  end

  it 'Fill search by last name' do
    when_i_fill_search_field_with('D')
    then_i_expect_to_see_list_of_users_by('last_name', search_text)
  end

  it 'Fill search by email' do
    when_i_fill_search_field_with('examp@')
    then_i_expect_to_see_list_of_users_by('email', search_text)
  end

  it 'Fill search by phone' do
    when_i_fill_search_field_with('+380')
    then_i_expect_to_see_list_of_users_by('phone', search_text)
  end

  def given_page_list_of_users_with_logged_user
    sign_in(users.first)
    expect(page).to have_content 'List of users'
  end

  def when_i_fill_search_field_with(text)
    find('input#search').set text
  end

  def search_text
    find('input#search').value
  end

  def then_i_expect_to_see_list_of_users_by(field, text)
    count_trs = page.evaluate_script("document.querySelectorAll('tbody > tr').length;")
    count_users = users.select { |user| user[field].include? text }

    expect(count_trs).to eql(count_users.count)
  end
end
