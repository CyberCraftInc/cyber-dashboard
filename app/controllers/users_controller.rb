class UsersController < ApplicationController
  def index
    @projects = Project.all.to_json
    @users = User.as_json(User.filter(params[:id]))
    respond_to do |format|
      format.html
      format.json {render :json => @users}
    end
  end
end
