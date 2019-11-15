class RegistrationsController < Devise::RegistrationsController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  skip_before_action :verify_authenticity_token, only: :create
  # rubocop:enable Rails/LexicallyScopedActionFilter
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
