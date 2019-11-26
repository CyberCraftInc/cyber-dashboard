require 'rails_helper'

RSpec.describe TargetsController, type: :controller do
  describe 'GET #toggle_achieved' do
    context 'when user is admin' do
      let!(:admin) { FactoryBot.create(:admin) }
      let!(:event) { FactoryBot.create(:event, user: admin) }
      let!(:target) { FactoryBot.create(:target, event: event) }

      before do
        login_user admin
      end

      it 'mark as achieved if target is unachieved' do
        expect(target.achieved).to be_falsey

        params = { id: target.id }
        put :toggle_achieved, params: params, format: :json
        target.reload

        expect(target.achieved).to be_truthy
      end

      it 'mark as unachieved if target is achieved' do
        target.update(achieved: true)

        expect(target.achieved).to be_truthy

        params = { id: target.id }
        put :toggle_achieved, params: params, format: :json
        target.reload

        expect(target.achieved).to be_falsey
      end
    end

    context 'when user is simple user' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:event) { FactoryBot.create(:event, user: user) }
      let!(:target) { FactoryBot.create(:target, event: event) }

      before do
        login_user user
      end

      it 'not mark as achieved if target is unachieved' do
        params = { id: target.id }
        put :toggle_achieved, params: params, format: :json
        expect(response.body).to have_text "The page you were looking for doesn't exist"
      end
    end
  end
end
