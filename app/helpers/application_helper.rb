module ApplicationHelper
  def current_user_owns?(project)
    return false unless user_signed_in?

    current_user.owns?(project)
  end

  def title
    key = "#{params[:controller].underscore.gsub('/', '.')}.#{params[:action]}"
    case key
    when "projects.show", "pages.show"
      @project.title
    else
      t "#{key}.title"
    end
  end

  def or_back_link
    t('views.or_back_link', href: link_to(t('views.back'), :back)).html_safe
  end
end
