require 'rails_helper'

RSpec.describe 'Project', type: :feature do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user, project: project) }
  let!(:second_user) { create(:user, project: project) }

  before do
    sign_in(user)
    visit project_path(id: project.id)
  end

  it 'check info about project' do
    expect(page).to have_content project.name
    expect(page).to have_content project.desc
  end

  it 'check info about team and visit profile page from project' do
    expect(page).to have_content user.first_name
    expect(page).to have_content user.last_name
    expect(page).to have_content user.position
    expect(page).to have_content second_user.first_name
    expect(page).to have_content second_user.last_name
    expect(page).to have_content second_user.position

    find("#open-profile#{second_user.id}").click

    expect(page).to have_content second_user.first_name
    expect(page).to have_content second_user.last_name
    expect(page).to have_content second_user.position
    expect(page).not_to have_content user.last_name
  end
end
