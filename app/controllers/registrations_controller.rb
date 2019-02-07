class RegistrationsController < Devise::RegistrationsController
  before_action :projects, only: %i[new create], if: -> { :projects }
  protected

  def projects
    @projects = Project.all
  end

  def update_resource(resource, params)
    return super if params['password']&.present?

    resource.update_without_password(params.except('current_password'))
  end
end
