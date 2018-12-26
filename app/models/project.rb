class Project < ApplicationRecord
  has_many :users, dependent: :nullify
end
