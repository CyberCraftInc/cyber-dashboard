class TargetPolicy < ApplicationPolicy
  def toggle_achieved?
    user.admin?
  end
end
