module PublicUrlHelper
  def public_project_page_uri(project)
    host =
      if project.domain
        project.domain
      else
        project.slug + '.' + Rails.application.config.x.host
      end
    URI::HTTP.build(host: host, port: request.port)
  end

  def public_project_url(project)
    public_project_page_uri(project).to_s
  end

  def public_project_page_url(project, page)
    uri = public_project_page_uri(project)
    uri.path = "/" << page.slug
    uri.to_s
  end
end
