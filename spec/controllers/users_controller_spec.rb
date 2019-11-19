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

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:params) do
      {
        format: 'json',
        id: user.id,
        user: {
          first_name: 'Jonatan',
          last_name: 'Edison',
          phone: '+380631231231',
          current_password: user.password
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
        expect(response).to have_http_status(:ok)
        expect(user.first_name).to eq('Jonatan')
        expect(user.last_name).to eq('Edison')
        expect(user.phone).to eq('+380631231231')
      end
    end

    context 'when parameter is invalid' do
      it 'fail in updating user' do
        params[:user][:first_name] = ''
        params[:user][:phone] = '30631231231'
        put :update, params: params

        user.reload
        expect(response).to have_http_status(:ok)
        expect(user.first_name).not_to be_empty
        expect(user.first_name).not_to eq('Jonatan')
        expect(user.last_name).not_to eq('Edison')
        expect(user.phone).not_to eq('30631231231')
      end
    end
  end
end
