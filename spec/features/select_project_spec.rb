require 'rails_helper'

describe 'Select Project', type: :feature do
  # Create 1 project with 2 users, 1 project with 1 user and project without users
  let!(:project_with_2_users) { FactoryBot.create(:project) }
  let!(:project_with_user) { FactoryBot.create(:project) }
  let!(:project_without_user) { FactoryBot.create(:project) }
  let!(:first_user) { FactoryBot.create(:user, project: project_with_2_users) }
  let!(:second_user) { FactoryBot.create(:user, project: project_with_2_users) }
  let!(:third_user) { FactoryBot.create(:user, project: project_with_user) }

  before do
    sign_in(first_user)
  end

  it 'returns all users if project is not provided', js: true do
    select project_with_user.name
    select 'All employees'

    expect(page).to have_content first_user.email
    expect(page).to have_content second_user.email
    expect(page).to have_content third_user.email
  end

  it 'returns all project users if project is provided', js: true do
    select project_with_2_users.name

    expect(page).to have_content first_user.email
    expect(page).to have_content second_user.email
    expect(page).not_to have_content third_user.email
  end

  it 'returns empty select if project is provided but project does not have users', js: true do
    select project_without_user.name

    expect(page).not_to have_content first_user.email
    expect(page).not_to have_content second_user.email
    expect(page).not_to have_content third_user.email
  end
end
