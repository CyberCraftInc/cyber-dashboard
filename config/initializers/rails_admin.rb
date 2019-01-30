RailsAdmin.config do |config|
  config.parent_controller = 'ApplicationController'
  config.authorize_with :pundit
  config.current_user_method(&:current_user)
  config.label_methods << :description

  config.model 'User' do
    object_label_method do
      :custom_label_user
    end
  end

  config.model 'Project' do
    object_label_method do
      :custom_label_project
    end
  end

  config.model 'Event' do
    object_label_method do
      :custom_label_event
    end
  end

  config.model 'Target' do
    object_label_method do
      :custom_label_target
    end
  end

  def custom_label_user
    "#{first_name}  #{last_name}"
  end

  def custom_label_project
    name
  end

  def custom_label_event
    "#{description}  #{finish_date}"
  end

  def custom_label_target
    description
  end
end

module RailsAdmin
  module Extensions
    module Pundit
      class AuthorizationAdapter
        def authorize(action, abstract_model = nil, model_object = nil)
          record = model_object || abstract_model&.model
          if action && !policy(record).send(*action_for_pundit(action))
            raise ::Pundit::NotAuthorizedError, "not allowed to #{action} this #{record}"
          end

          @controller.instance_variable_set(:@_pundit_policy_authorized, true)
        end

        def authorized?(action, abstract_model = nil, model_object = nil)
          record = model_object || abstract_model&.model
          policy(record).send(*action_for_pundit(action)) if action
        end

        def action_for_pundit(action)
          [:rails_admin?, action]
        end
      end
    end
  end
end
