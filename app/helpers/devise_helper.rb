module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    content_tag(:div, id: 'error_explanation') do
      concat content_tag(:h5, sentence)
      concat content_tag(:ul, safe_join(messages))
    end
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
