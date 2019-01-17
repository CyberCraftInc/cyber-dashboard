class Target < ApplicationRecord
  belongs_to :event
  include Rails.application.routes.url_helpers

  def data
    {
      id: id,
      description: description,
      achieved: achieved,
      toggle_achieved_path: toggle_achieved_target_path(self)
    }
  end
end
