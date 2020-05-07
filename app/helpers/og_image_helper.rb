module OgImageHelper
  def opengraph_image_link
    "/images/opengraph/#{@project.id}/#{@page.id}/og-image.png"
  end
end
