require 'rails_helper'
require 'login_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    context 'without login' do
      before(:each) do
        get :index
      end
      it 'returns current user as a nil and status 302' do
        expect(response).to have_http_status(302)
        expect(subject.current_user).to be_nil
      end
      it 'redirects to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'for login' do
      let(:user) { FactoryBot.create(:user) }
      it 'returns valid current_user and status 200' do
        login_user(user)
        get :index
        expect(response).to have_http_status(200)
        expect(subject.current_user).to_not be_nil
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:params) do
      {
        format: 'json',
        id: user.id,
        user: {
          first_name: 'Jonatan',
          last_name: 'Edison',
          phone: '063123123'
        }
      }
    end

    before do
      sign_in(user)
    end

    context 'when parameter is valid' do
      it 'succeeds in updating user' do
        put :update, params: params

        user.reload
        expect(response).to have_http_status(200)
        expect(user.first_name).to eq('Jonatan')
        expect(user.last_name).to eq('Edison')
        expect(user.phone).to eq('063123123')
      end
    end

    context 'when parameter is invalid' do
      it 'fail in updating user' do
        params[:user][:first_name] = ''
        put :update, params: params

        user.reload
        expect(response).to have_http_status(200)
        expect(user.first_name).not_to be_empty
        expect(user.first_name).to_not eq('Jonatan')
        expect(user.last_name).to_not eq('Edison')
        expect(user.phone).to_not eq('063123123')
      end
    end
  end
end
