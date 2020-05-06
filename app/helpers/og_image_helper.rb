module OgImageHelper
  def og_image
    img = Magick::ImageList.new('public/images/qkspace.png')

    title = Magick::Draw.new
    title.pointsize = 100
    title.font_weight = Magick::NormalWeight
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, -200,  wrap_text(@page.title, 40))

    descritpion = Magick::Draw.new
    descritpion.pointsize = 60
    descritpion.font_weight = Magick::NormalWeight
    descritpion.fill = 'white'
    descritpion.interline_spacing = 6
    descritpion.gravity = Magick::SouthWestGravity
    descritpion.annotate(img, 0, 0, 100, 130, wrap_text((page_descritpion(@page))))

    dir = "public/images/#{@project.id}/#{@page.id}"

    File.exist?(dir) ? img.write("#{dir}/og-image.png") : (FileUtils.makedirs(dir) && img.write("#{dir}/og-image.png"))
  end

  def wrap_text(text, col = 55)
    text.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  def page_descritpion(page)
    result = sanitize(page.html, tags: [], attributes: [])
    truncate(result, length: 230, separator: "\n", omission: " ...")
    .gsub('&quot;', '"').gsub('~~', '')
  end
end
