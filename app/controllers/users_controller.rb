class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all.to_json
    @users = User.filter(params[:id]).map(&:data)

    json_response(users: @users, projects: @projects)
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @events = EventPolicy::Scope.new(current_user, @user.events).resolve.sort_reverse_by_finish_date
    @statuses = Event.statuses.keys
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :birthday,
                                 :password, :password_confirmation, :current_password, :avatar)
  end
end
