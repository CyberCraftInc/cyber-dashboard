# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :project

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :confirmable, omniauth_providers: [:google_oauth2]

  validates :phone, :email, uniqueness: true
  validates :first_name, :last_name, :phone, :project, presence: true
  validates :phone, length: { is: 12 }

  scope :users_joins_project, -> { includes(:project) }
  enum role: { admin: 0, employee: 1 }

  def self.filter(id)
    @users = id.to_i.zero? ? User.users_joins_project : Project.find(id.to_i).users.users_joins_project
  end

  def signature_hash
    OpenSSL::HMAC.hexdigest('sha256', created_at.to_s, id.to_s)
  end

  def data
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      birthday: birthday,
      position: position,
      start_in_company: start_in_company.presence || created_at.strftime('%m/%d/%Y'),
      project: {
        id: project.id,
        name: project.name,
        desc: project.desc
      }
    }
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.new(
        first_name: data.name.partition(' ').first,
        last_name: data.name.partition(' ').last,
        email: data.email, project: Project.first,
        password: password, password_confirmation: password
      )
    end
    user
  end
end
