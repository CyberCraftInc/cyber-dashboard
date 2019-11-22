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
          phone: '380631231231',
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
        expect(user.phone).to eq('380631231231')
      end
    end

    context 'when parameter is invalid' do
      it 'fail in updating user' do
        params[:user][:first_name] = ''
        put :update, params: params

        user.reload
        expect(response).to have_http_status(:ok)
        expect(user.first_name).not_to be_empty
        expect(user.first_name).not_to eq('Jonatan')
        expect(user.last_name).not_to eq('Edison')
        expect(user.phone).not_to eq('380631231231')
      end
    end
  end

  describe 'GET #ics_export' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns without login' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns text/calendar and status 200' do
      get :ics_export, params: { user_id: user.id, signature: user.signature_hash }
      expect(response.content_type).to eq 'text/calendar'
    end

    it 'return 404 when signature is invalid' do
      get :ics_export, params: { user_id: user.id, signature: 'invalid signature' }
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq 'application/json'
      expect(JSON.parse(response.body)['error']).to eq 'not-found'
    end
  end
end
