require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Valid?' do
    let(:user) { build(:user) }

    it 'valid with valid attributes' do
      expect(user).to be_valid
    end
  end

  describe '.filter' do
    let(:first_project) { create(:project, name: 'first_project') }
    let(:second_project) { create(:project, name: 'second_project') }

    let(:foo) { create(:user, project: first_project) }
    let(:bar) { create(:user, project: first_project) }
    let(:john) { create(:user, project: second_project) }

    context 'when parameter 0' do
      it 'gets all users' do
        expected_all_user_ids = [foo.id, bar.id, john.id]
        expect(User.filter(0).map(&:id)).to eq expected_all_user_ids
      end
    end

    context 'when parameter is associative project' do
      it 'returns filtered users by this project' do
        expected_user_ids = [foo.id, bar.id].sort
        expect(User.filter(first_project.id).map(&:id).sort).to eq(expected_user_ids)
      end
    end
  end

  describe 'data' do
    context 'when array of instances converting to json' do
      let(:project) { create(:project) }
      let(:user) { create(:user, project: project) }

      it 'returns an array of objects as json' do
        as_json = user.data

        expect(as_json[:first_name]).to eq(user.first_name)
        expect(as_json[:last_name]).to eq(user.last_name)
        expect(as_json[:email]).to eq(user.email)
        expect(as_json[:phone]).to eq(user.phone)

        expect(as_json[:project][:name]).to eq(user.project.name)
        expect(as_json[:project][:desc]).to eq(user.project.desc)
      end
    end
  end

  describe '.from_omniauth' do
    context 'when single sign-on via Google' do
      let(:access_token) { google_oauth2_mock }
      let(:user) { create(:user, email: 'fakeemail@gmail-fake.com') }
      let(:user_sso) { User.from_omniauth(access_token) }

      it 'is retrieve existent user if user exist in data base' do
        email = user.email

        expect(user_sso).not_to be_a_new(User)
        expect(user_sso.email).to eq email
      end

      it 'returns prepared new user for next step of registration if user absent in data base' do
        first_name = 'David'
        last_name = 'McDonald'

        expect(user_sso).to be_a_new(User)
        expect(user_sso.first_name).to eq first_name
        expect(user_sso.last_name).to eq last_name
      end
    end
  end
end
