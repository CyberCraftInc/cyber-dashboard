class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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
      u.permit(:first_name, :last_name, :phone, :project_id,
               :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :phone, :email)
    end
  end
end
