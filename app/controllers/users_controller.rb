class UsersController < ApplicationController
  def index
    @users = User.joins(:project)
    .select('users.first_name,users.last_name,users.email,users.phone,projects.name')
  end
end
