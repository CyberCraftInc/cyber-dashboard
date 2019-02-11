require 'rails_helper'

RSpec.feature 'Edit user', type: :feature do
  let(:user) { create(:user, password: 'oldpass') }
  let(:user_edited) { build(:user) }

  before(:each) do
    sign_in(user)
    visit_edit_page
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
    expect(find('input#userPhone').value).to eq(user_edited.phone)
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

  scenario 'Success edit password' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'oldpass'
    click_button 'Update'

    expect(page).to_not have_content('Current password is invalid')

    open_dropdown_and_click_on 'Logout'
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'newpass'
    click_button 'Log in'

    expect(page).to have_content('List of users')
  end

  scenario 'Failed edit password' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'notoldpass'
    click_button 'Update'

    expect(page).to have_content('Current password is invalid')
  end

  private

  def error_messages
    error = find('span#notice').value
    expect(page).to have_content error
  end

  def when_fill_and_submit_form
    fill_in 'Current password', with: user.password
    fill_in 'userFirstName', with: user_edited.first_name
    fill_in 'userLastName', with: user_edited.last_name
    fill_in 'userPhone', with: ''
    fill_in 'userPhone', with: phone_without_ukraine_code(user_edited.phone)
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
