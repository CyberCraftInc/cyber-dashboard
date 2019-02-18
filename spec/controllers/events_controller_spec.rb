require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  before(:each) do
    login_user admin
  end

  describe 'POST :create' do
    let(:event_params) do
      {
        description: 'Description title',
        status: 'scheduled',
        start_date: Time.zone.local(2019, 'jan', 1),
        finish_date: Time.zone.local(2019, 'jan', 2),
        comments: 'Comment about event',
        summary: 'Summary about event',
        user_id: user.id,
        targets_attributes: [
          { description: 'Test data' },
          { description: 'Test data 2' }
        ]
      }
    end

    it 'create with valid params' do
      expect do
        post :create, params: { event: event_params }, format: :json
      end.to change { user.events.count }.by(1)

      event = user.events.last

      expect(event.description).to eq('Description title')
      expect(event.status).to eq('scheduled')
      expect(event.start_date.in_time_zone).to eq(Time.zone.local(2019, 'jan', 1))
      expect(event.finish_date.in_time_zone).to eq(Time.zone.local(2019, 'jan', 2))
      expect(event.comments).to eq('Comment about event')
      expect(event.summary).to eq('Summary about event')
      expect(event.targets.count).to eq(2)

      expect(response_json['status']).to eq('created')
    end

    it 'send email when created event' do
      expect do
        post :create, params: { event: event_params }, format: :json
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'return error when finish date less than start date' do
      expect do
        post(
          :create,
          params: { event: event_params.merge(finish_date: event_params[:start_date] - 2.days) },
          format: :json
        )
      end.to change { user.events.count }.by(0)
      expect(response_json['finish_date']).to include("can't be less than start date")
    end

    it 'do not send email when failed create event' do
      expect do
        post(
          :create,
          params: { event: event_params.merge(finish_date: nil) },
          format: :json
        )
      end.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end

  describe 'PUT :update' do
    let!(:event) { create(:event, user_id: user.id, targets: create_list(:target, 2)) }

    let(:targets_params) do
      [
        {
          id: event.targets.first.id,
          description: 'Test data 1'
        },
        {
          id: event.targets.last.id,
          description: 'Test data 2'
        }
      ]
    end

    it 'update with valid params' do
      put(
        :update,
        params: { event: { description: 'New', targets_attributes: targets_params }, id: event.id },
        format: :json
      )

      event.reload
      expect(event.description).to eq('New')
      expect(event.status).to eq('scheduled')
      expect(event.targets.map(&:description)).to include('Test data 1', 'Test data 2')

      expect(response_json['status']).to eq('updated')
    end

    it 'should create new target' do
      expect do
        put(
          :update,
          params: {
            event: {
              description: 'New',
              targets_attributes: targets_params.push(
                id: nil,
                description: 'Test data 3'
              )
            }, id: event.id
          },
          format: :json
        )
      end.to change { event.targets.count }.by(1)

      event.reload
      expect(event.targets.map(&:description)).to include('Test data 1', 'Test data 2', 'Test data 3')
    end

    it 'should delete existing target' do
      expect do
        put(
          :update,
          params: {
            event: {
              description: 'New',
              targets_attributes: { id: event.targets.first.id, _destroy: true }
            }, id: event.id
          },
          format: :json
        )
      end.to change { event.targets.count }.by(-1)
    end

    it 'returns error when finish date less than start date' do
      put(
        :update,
        params: { event: { finish_date: event.start_date - 2.days }, id: event.id },
        format: :json
      )
      expect(response_json['finish_date']).to include("can't be less than start date")
    end
  end

  private

  def response_json
    JSON.parse(response.body)
  end
end
