class EventMailer < ApplicationMailer
  default from: 'dashboardcyber@gmail.com'

  def create_event
    @event = params[:event]
    @author = params[:author]
    @user = @event.user
    @url = user_url(id: @user.id)

    mail(to: @user.email, subject: 'New event in CyberDashboard!')
  end
end
