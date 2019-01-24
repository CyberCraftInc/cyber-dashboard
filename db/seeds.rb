Project.where(name: 'CyberCraftInc', desc: "It's not a project").first_or_create
Project.where(name: 'Solano Labs', desc: 'desc for Solano Labs project').first_or_create
User.create!(last_name: 'admin', first_name: 'admin', email: 'admin@admin.com', phone: '380785249866',
             password: 'adminadmin', role: 0, password_confirmation: 'adminadmin', project_id: 1)
User.create!(last_name: 'test', first_name: 'user', email: 'test@user.com', phone: '380785249861',
             password: 'qwerty', password_confirmation: 'qwerty', project_id: 2)
User.create!(last_name: 'default', first_name: 'user', email: 'default@user.com', phone: '380785249862',
             password: 'qwerty', password_confirmation: 'qwerty', project_id: 1)
User.create!(last_name: 'lorem', first_name: 'ipsum', email: 'lorem@ipsum.com', phone: '380785249869',
             password: 'qwerty', password_confirmation: 'qwerty', project_id: 2)
