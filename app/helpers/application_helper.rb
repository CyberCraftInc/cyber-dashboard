module ApplicationHelper
  def user_edit_page?
    current_page? edit_user_registration_path
  end

  def current_user_fields_have_nil?
    user_attributes = current_user.attributes
    user_attributes.except!(
      'encrypted_password', 'reset_password_token',
      'reset_password_sent_at', 'remember_created_at'
    )
    user_attributes = user_attributes.map { |_key, value| value.nil? || value.to_s.empty? || value.blank? }
    user_attributes.include?(true)
  end

  def hash_to_react_props(hash_object)
    hash_object.deep_stringify_keys.to_s.gsub('=>',':')
  end
end
