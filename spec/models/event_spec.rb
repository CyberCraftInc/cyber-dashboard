require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'to_ics' do
    let(:event) { create(:event) }

    it 'return Icalendar Event' do
      calendar_event = JSON.parse(event.to_ics.to_json)
      expect(calendar_event["name"]).to eq "event"
      expect(calendar_event["ical_name"]).to eq "VEVENT"
      expect(calendar_event["summary"]).to eq event.description
      expect(calendar_event["comment"]).to eq [event.comments]
    end
  end
end
