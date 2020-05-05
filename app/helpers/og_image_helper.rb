module OgImageHelper
  def og_image
    img = Magick::ImageList.new('public/images/qkspace.png')

    title = Magick::Draw.new
    title.pointsize = 126
    title.font_weight = Magick::NormalWeight
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, -150, @page.title)

    descritpion = Magick::Draw.new
    descritpion.pointsize = 72
    descritpion.font_weight = Magick::NormalWeight
    descritpion.fill = 'white'
    descritpion.gravity = Magick::CenterGravity
    descritpion.annotate(img, 0, 0, 0, 300, wrap_text((page_descritpion(@page))))

    dir = "public/images/#{@project.id}/#{@page.id}"

    File.exists?(dir) ? img.write("#{dir}/og-image.png") : (FileUtils.makedirs(dir) && img.write("#{dir}/og-image.png"))
  end

  def wrap_text(text, col = 50)
    text.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  def page_descritpion(page)
    result = sanitize(page.html, tags: [], attributes: [])
    truncate(result, length: 350, separator: ' ', omission: ' ...')
  end
end
