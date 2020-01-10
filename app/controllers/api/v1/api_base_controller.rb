# Chipotle Software (c) 2016-2017  MIT License
module Api
  module V1
    class ApiBaseController < ::ActionController::Base
      protect_from_forgery with: :null_session
      include Pundit
      include Response
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      protect_from_forgery with: :exception
      before_action :configure_permitted_parameters, if: :devise_controller?
      respond_to :html, :json

      def header
        return if current_user.nil?

        json_response(
          username: current_user.first_name,
          isAdmin: current_user.admin?,
          profileLink: user_path(current_user),
          adminLink: rails_admin_path,
          logoutLink: destroy_user_session_path
        )
      end

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |u|
          u.permit(:first_name, :last_name, :phone, :project_id, :birthday,
                   :email, :password, :password_confirmation, :start_in_company, :position)
        end
        devise_parameter_sanitizer.permit(:account_update) do |u|
          u.permit(:first_name, :last_name, :phone,
                   :email, :birthday, :password, :password_confirmation, :current_password)
        end
      end

      private

      def authenticate_user!
        if user_signed_in?
          super
        else
          redirect_to session_path('/login')
        end
      end

      def user_not_authorized
        render file: File.join(Rails.public_path, '404'), formats: [:html], status: 404, layout: false
      end
    end
  end
end
