require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #show' do
    let(:project) { FactoryBot.create(:project) }

    context 'without login' do
      before do
        get :show, params: { id: project.id }
      end

      it 'returns current user as a nil and status 302' do
        expect(response).to have_http_status(:found)
        expect(subject.current_user).to be_nil
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      let(:user) { FactoryBot.create(:user, project: project) }

      it 'returns valid current_user and status 200' do
        login_user(user)
        get :show, params: { id: project.id }
        expect(response).to have_http_status(:ok)
        expect(subject.current_user).not_to be_nil
      end
    end
  end
end
