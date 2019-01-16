# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :phone, :email, uniqueness: true
  validates :first_name, :last_name, :phone, :project_id, presence: true
  belongs_to :project
  has_many :events, dependent: :destroy
  scope :users_joins_project, -> { includes(:project) }

  def self.filter(id)
    @users = id.to_i.zero? ? User.users_joins_project : Project.find(id.to_i).users.users_joins_project
  end

  def self.as_json(users)
    users_lst_for_json = users.map do |user|
      user_project_info = user.project
      {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone: user.phone,
        project: {
          id: user_project_info.id,
          name: user_project_info.name,
          desc: user_project_info.desc
        }
      }
    end
    users_lst_for_json.to_json
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

  def self.event_as_json(user)
    events_lst_for_json = user.events.order(finish_date: :desc).map do |event|
      {
        id: event.id,
        description: event.description,
        start_date: event.start_date,
        finish_date: event.finish_date,
        comments: event.comments,
        summary: event.summary,
        targets: event.targets
      }
    end

    events_lst_for_json.to_json
  end
end
