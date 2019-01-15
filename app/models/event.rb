class Event < ApplicationRecord
  has_many :targets, dependent: :nullify
  belongs_to :user
end
