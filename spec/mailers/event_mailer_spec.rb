require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:event) { FactoryBot.create(:event, user: admin) }
  let(:mail) { EventMailer.with(event: event, author: admin).create_event }

  it 'renders the headers' do
    expect(mail.subject).to eq('New event in CyberDashboard!')
    expect(mail.from).to eq(['dashboardcyber@gmail.com'])
    expect(mail.to).to eq([event.user.email])
  end

  it 'renders the body' do
    expect(mail.body.encoded).to match('To login to the site, just follow this link')
    expect(mail.body.encoded).to match(admin.first_name)
    expect(mail.body.encoded).to match(admin.last_name)
    expect(mail.body.encoded).to match(event.description)
  end
end
