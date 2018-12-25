class User < ApplicationRecord
  belongs_to :project
  scope :users_joins_project, -> {includes(:project)}

  def self.filter(id)
    @users = id.to_i == 0 ? User.users_joins_project : Project.find(id.to_i).users.users_joins_project
  end

  def self.as_json(users)
    users_lst_for_json = users.map do |user|
      user_project_info = user.project
      user_item = {
        :id => user.id,
        :first_name => user.first_name,
        :last_name => user.last_name,
        :email => user.email,
        :phone => user.phone,
        :project => {
          :id => user_project_info.id,
          :name => user_project_info.name,
          :desc => user_project_info.desc,
        }
      }
    end
    users_lst_for_json.to_json
  end
end
