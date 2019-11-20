class ApplicationPolicy
  attr_reader :user, :record
  ADMIN_ACTION = %i[dashboard index show new edit destroy export history show_in_app create update].freeze

  def initialize(user, record)
    @user = user
    @record = record
  end

  def rails_admin?(action)
    return user.admin? if ADMIN_ACTION.include?(action)

    raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
  end
end
