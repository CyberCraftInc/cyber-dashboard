class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Pundit
  include Response
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :json

  protected

  # Might be useful for future tasks as  ( before_action :check_user_fields for Users_controller.rb )
  #   def check_user_fields
  #     flash[:noice] = 'Lalal'
  #     unless current_user.nil?
  #       if helpers.current_user_fields_have_nil?
  #         unless helpers.user_edit_page?
  #           redirect_to edit_user_registration_path
  #         end
  #       end
  #     end
  #   end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :phone, :project_id, :birthday,
               :email, :password, :password_confirmation, :start_in_company, :position, :avatar)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(
        :first_name, :last_name, :phone, :email, :birthday,
        :password, :password_confirmation, :current_password, :avatar
      )
    end
  end

  private

  def user_not_authorized
    render file: File.join(Rails.public_path, '404'), formats: [:html], status: 404, layout: false
  end
end
