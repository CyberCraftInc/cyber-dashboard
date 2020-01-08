require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
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
