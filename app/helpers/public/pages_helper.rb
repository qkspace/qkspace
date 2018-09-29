module Public::PagesHelper
  # Facebook truncates text descriptions at that length
  MAGIC_FACEBOOK_NUMBER = 300

  def page_brief(page)
    result = sanitize(page.html, tags: [], attributes: [])
    truncate(result, length: MAGIC_FACEBOOK_NUMBER, separator: ' ', omission: " >>")
  end
end
