require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    context 'without login' do
      before do
        get :index
      end

      it 'returns current user as a nil and status 302' do
        expect(response).to have_http_status(:found)
        expect(subject.current_user).to be_nil
      end

      it 'redirects to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      let(:user) { FactoryBot.create(:user) }

      it 'returns valid current_user and status 200' do
        login_user(user)
        get :index
        expect(response).to have_http_status(:ok)
        expect(subject.current_user).not_to be_nil
      end
    end
  end
end
