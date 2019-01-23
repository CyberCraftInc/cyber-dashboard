require 'rails_helper'

RSpec.describe TargetsController, type: :controller do
  describe 'GET #toggle_achieved' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event, user: user) }
    let!(:target) { FactoryBot.create(:target, event: event) }

    before(:each) do
      login_user user
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
end
