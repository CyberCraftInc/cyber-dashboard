Project.where(name: 'CyberCraftInc', desc: "It's not a project").first_or_create
User.create!(last_name: 'admin', first_name: 'admin', email: 'admin@admin.com', phone: '380785249866',
             password: 'adminadmin', role: 0, password_confirmation: 'adminadmin', project_id: 1)
