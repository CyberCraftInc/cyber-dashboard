require 'rails_helper'

RSpec.feature 'Edit user', type: :feature do
  let(:user) { create(:user) }
  let(:user_edited) { build(:user) }

  before(:each) do
    sign_in(user)
    visit_edit_page
  end

  scenario 'show profile page' do
    open_dropdown_and_click_on('Profile')

    expect(page).to have_content 'Profile page'
    expect(page).to have_content user.first_name
    expect(page).to have_content user.last_name
    expect(page).to have_content user.phone
  end

  scenario 'show edit page' do
    open_dropdown_and_click_on('Edit profile')
    expect(page).to have_content 'Profile information'
  end

  scenario 'show root after logout' do
    open_dropdown_and_click_on('Logout')
    expect(page).to_not have_content user.first_name
  end

  scenario 'Success edit user' do
    when_fill_and_submit_form

    expect(find('input#userFirstName').value).to eq(user_edited.first_name)
    expect(find('input#userLastName').value).to eq(user_edited.last_name)
    expect(find('input#userPhone').value).to eq("38#{user_edited.phone}")
    expect(page).to have_content 'Profile updated'
  end

  scenario 'Error edit user when empty first name' do
    fill_empty_field_and_submit 'userFirstName'
    error_messages
  end

  scenario 'Error edit user when empty last name' do
    fill_empty_field_and_submit 'userLastName'
    error_messages
  end

  private

  def error_messages
    error = find('span#notice').value
    expect(page).to have_content error
  end

  def when_fill_and_submit_form
    fill_in 'userFirstName', with: user_edited.first_name
    fill_in 'userLastName', with: user_edited.last_name
    fill_in 'userPhone', with: ''
    fill_in 'userPhone', with: user_edited.phone
    find('button#button-edit').click
  end

  def fill_empty_field_and_submit(field)
    fill_in field, with: ''
    find('button#button-edit').click
  end

  def open_dropdown_and_click_on(link_text)
    find('span', text: user.first_name).click
    find('li > a', text: link_text, visible: false).click
  end

  def visit_edit_page
    visit edit_user_path(user)
  end
end
