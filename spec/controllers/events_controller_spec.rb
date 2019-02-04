require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'POST events#create' do
    let!(:admin) { FactoryBot.create(:admin) }

    before(:each) do
      login_user admin
    end

    it 'send email when create event' do
      params = { event: { description: 'some description', finish_date: Time.current, user_id: admin.id } }

      expect { post :create, params: params, format: :json }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(Event.where(description: 'some description')).to exist
    end

    it 'do not send email when failed create event' do
      params = { event: { description: 'some description', finish_date: Time.current } }

      expect { post :create, params: params, format: :json }.to change { ActionMailer::Base.deliveries.count }.by(0)
      expect(Event.where(description: 'some description')).to_not exist
    end
  end
end
