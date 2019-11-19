require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user, project: project) }

  describe 'GET #show' do
    context 'without login' do
      it 'returns current user as a nil and status 302' do
        get :show, params: {id: project.id}
        expect(response).to have_http_status(:found)
        expect(subject.current_user).to be_nil
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is logged in' do
      it 'returns valid current_user and status 200' do
        login_user(user)
        get :show, params: {id: project.id}
        expect(response).to have_http_status(:ok)
        expect(subject.current_user).not_to be_nil
      end
    end
  end
end
