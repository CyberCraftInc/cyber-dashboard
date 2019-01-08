class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all.to_json
    @users = User.as_json(User.filter(params[:id]))
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
