class OgImageService
  def initialize(project_id, page_id, page_title)
    @project_id = project_id
    @page_id = page_id
    @page_title = page_title
  end

  def generate
    img = Magick::ImageList.new("#{Rails.root}/public/images/qkspace.png")

    title = Magick::Draw.new
    title.font = "#{Rails.root}/public/assets/Lato-Regular.woff"
    title.pointsize = 46
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, 140, wrap_text(@page_title))

    FileUtils.mkdir_p(og_image_path)

    img.write("#{og_image_path}/og-image.jpg")
  end

  def og_image_path
    if Rails.env.test?
      "#{Rails.root}/public/images/opengraph/test/#{@project_id}/#{@page_id}"
    else
      "#{Rails.root}/public/images/opengraph/#{@project_id}/#{@page_id}"
    end
  end

  private

  def wrap_text(text, col = 50)
    # Regular expression to limit the number of chars per line
    # default 50 chars each line
    text.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end
end
