class Event < ApplicationRecord
  has_many :targets, dependent: :destroy
  belongs_to :user
  enum status: %i[scheduled done]
end
