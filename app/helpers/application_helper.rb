module ApplicationHelper
  def current_user_edits_project?
    current_user&.edits?(@project)
  end

  def current_user_owns_project?
    current_user&.owns?(@project)
  end

  def link_to_or_disable_current(text, url, *options)
    link_to_unless_current(text, url, *options) do
      content_tag :span, text, class: 'text-muted'
    end
  end

  def show_header?
    signed_in? && (private_controller? || current_user_edits_project?)
  end

  def or_back_link
    t('views.or_back_link', href: link_to(t('views.back'), :back)).html_safe
  end

  def link_to_switch_locale
    current_locale_index = I18n.available_locales.find_index(I18n.locale)
    next_locale = I18n.available_locales[(current_locale_index + 1) % I18n.available_locales.length]

    country_code = next_locale.to_s.split('-').last.downcase # en-US -> us
    country_code = 'us' if country_code == 'en' # we don't have EN flag for now

    link_to %{<span class="flag-icon flag-icon-#{country_code}"></span>}.html_safe,
      {locale: next_locale},
      title: t('views.switch_locale', locale: next_locale)
  end

  def main_host_url(path)
    uri = URI::HTTP.build(host: Rails.application.config.x.host, port: request.port, path: path)
    uri.scheme = request.scheme
    uri.to_s
  end

  def opengraph_image_link
    main_host_url("/images/opengraph/#{@project.id}/#{@page.id}/og-image.jpg")
  end
end
