# Chipotle Software (c) 2016  MIT License
module Api
  module V1
    class UsersController < ApiBaseController
      before_action :set_user, only: %i[edit update]

      def edit
        json_response(user: @user, updatePath: '/api/v1' + user_path(current_user))
      end

      def update
        if @user.update_with_password(user_params)
          bypass_sign_in(@user)
          json_response(success: @user)
        else
          json_response(errors: @user.errors.full_messages)
        end
      end

      def show
        @events = EventPolicy::Scope.new(current_user, @user.events).resolve.sort_reverse_by_finish_date
        @statuses = Event.statuses.keys
        json_response(user: @user, events: @events, statuses: @statuses)
      end

      protected

      def set_user
        @user = params[:id] && params[:id] != 'current' ? User.find(params[:id]) : current_user
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :phone, :birthday,
                                     :password, :password_confirmation, :current_password)
      end
    end
  end
end
