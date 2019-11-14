module ReactHelper
  def react_component(name, props = {})
    content_tag(:div, '', data: { react_component: { name: name, props: props } })
  end

  def react_header_props
    return {} unless current_user

    {
      username: current_user.first_name,
      isAdmin: current_user.admin?,
      editUserLink: edit_user_path(current_user),
      profileLink: user_path(current_user),
      adminLink: rails_admin_path,
      logoutLink: destroy_user_session_path
    }
  end
end
