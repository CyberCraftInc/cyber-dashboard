require 'rails_helper'

RSpec.describe 'Edit user', type: :feature do
  let(:user) { create(:user, password: 'oldpass') }
  let(:user_edited) { build(:user) }

  before do
    sign_in(user)
    visit '/edit'
  end

  it 'show edit page' do
    open_dropdown_and_click_on('Edit profile')
    expect(page).to have_content 'Profile information'
  end

  it 'show root after logout' do
    open_dropdown_and_click_on('Logout')
    expect(page).not_to have_content user.first_name
  end

  it 'Success edit user' do
    when_fill_and_submit_form
    have_selector 'input#userFirstName', text: user_edited.first_name
    have_selector 'input#userLastName', text: user_edited.last_name
    have_selector 'input#userPhone', text: user_edited.phone
    have_selector 'input#userAvatar', text: 'logo-test.png'
    expect(page).to have_content 'Profile updated'
    sleep(5)
    expect(page).to have_current_path root_path
  end

  it 'Error edit user when empty first name' do
    fill_empty_field_and_submit 'userFirstName'
    error_messages
  end

  it 'Edit user when empty avatar' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'oldpass'
    click_button 'Update'

    error_messages
  end

  it 'Edit user with big image size for avatar' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'oldpass'
    attach_file 'userAvatar', Rails.root.join('public/test.png')
    click_button 'Update'

    error_messages
  end

  it 'Edit user with invalid image type' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'oldpass'
    attach_file 'userAvatar', Rails.root.join('public/robots.txt')
    click_button 'Update'

    error_messages
  end

  it 'Error edit user when empty last name' do
    fill_empty_field_and_submit 'userLastName'
    error_messages
  end

  it 'Success edit password' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'oldpass'
    fill_in 'userPhone', with: phone_without_ukraine_code(user_edited.phone)
    click_button 'Update'

    expect(page).not_to have_content('Current password is invalid')

    open_dropdown_and_click_on 'Logout'
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'newpass'
    click_button 'Log in'

    expect(page).to have_content('All employees')
  end

  it 'Failed edit password' do
    fill_in 'New password', with: 'newpass'
    fill_in 'Confirm new password', with: 'newpass'
    fill_in 'Current password', with: 'notoldpass'
    click_button 'Update'

    expect(page).to have_content('Current password is invalid')
  end

  private

  def error_messages
    error = find('span#notice').value
    expect(page).to have_text error.to_s
    expect(page).not_to have_current_path root_path
  end

  def when_fill_and_submit_form
    fill_in 'Current password', with: user.password
    fill_in 'userFirstName', with: user_edited.first_name
    fill_in 'userLastName', with: user_edited.last_name
    fill_in 'userPhone', with: phone_without_ukraine_code(user_edited.phone)
    attach_file 'userAvatar', Rails.root.join('public/logo-test.png')

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
