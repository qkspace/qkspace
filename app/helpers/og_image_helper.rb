module OgImageHelper
  def og_image
    img = Magick::ImageList.new('public/images/qkspace.png')

    title = Magick::Draw.new
    title.pointsize = 126
    title.font_weight = Magick::NormalWeight
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, 0, @page.title)

    descritpion = Magick::Draw.new
    descritpion.pointsize = 64
    descritpion.font_weight = Magick::NormalWeight
    descritpion.fill = 'white'
    descritpion.gravity = Magick::SouthEastGravity
    descritpion.annotate(img, 0, 0, 100, 100, "#{request.original_url}")

    dir = "public/images/#{@project.id}/#{@page.id}"

    File.exists?(dir) ? img.write("#{dir}/og-image.png") : (FileUtils.makedirs(dir) && img.write("#{dir}/og-image.png"))
  end
end
