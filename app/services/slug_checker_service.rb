class SlugCheckerService
  def self.call(slug:, domain:)
    project = Project.new(slug: slug)
    project.validate

    slug_available = project.errors[:slug].empty?
    translation_key = "helpers.projects.slug_#{slug_available ? 'available' : 'not_available'}"
    message = I18n.t(translation_key)

    {
      slug: slug,
      domain: domain,
      message: message,
      availability: slug_available,
    }
  end
end
