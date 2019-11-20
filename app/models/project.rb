class Project < ApplicationRecord
  has_many :users, dependent: :nullify
  validates :name, presence: true

  def data
    {
      name: name,
      desc: desc,
      users: users.map(&:data)
    }
  end
end
