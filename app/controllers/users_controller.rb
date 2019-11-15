class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all.to_json
    @users = User.filter(params[:id]).map(&:data)
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        format.json { render json:  { success: @user } }
      else
        format.json { render json:  { errors: @user.errors.full_messages } }
      end
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @events = EventPolicy::Scope.new(current_user, @user.events).resolve.sort_reverse_by_finish_date
    @statuses = Event.statuses.keys
  end

  def ics_export
    @events = Event.where(user_id: params[:user_id])
    respond_to do |format|
      format.ics do
        cal = Icalendar::Calendar.new
        @events.each do |event|
          cal.add_event(event.to_ics)
          cal.publish
        end
        render plain: cal.to_ical
      end
    end
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :birthday,
                                 :password, :password_confirmation, :current_password)
  end
end
