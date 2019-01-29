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
      if @user.update(user_params)
        format.json { render json:  { success: @user } }
      else
        format.json { render json:  { errors: @user.errors.full_messages } }
      end
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @events = EventPolicy::Scope.new(current_user, @user.events).resolve.sort_reverse_by_finish_date.map(&:data)
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone)
  end
end
