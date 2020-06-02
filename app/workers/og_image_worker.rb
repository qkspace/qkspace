class OgImageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project_id, page_id, page_title)
    img = Magick::ImageList.new("#{Rails.root}/public/images/qkspace.png")

    title = Magick::Draw.new
    title.font = "#{Rails.root}/public/assets/Lato-Regular.woff"
    title.pointsize = 46
    title.fill = 'white'
    title.gravity = Magick::CenterGravity
    title.annotate(img, 0, 0, 0, 140, wrap_text(page_title))

    dir = "#{Rails.root}/public/images/opengraph/#{project_id}/#{page_id}"
    FileUtils.mkdir_p(dir)

    img.write("#{dir}/og-image.jpg")
  end

  private

  def wrap_text(text, col = 50)
    # Regular expression to limit the number of chars per line
    # default 50 chars each line
    text.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end
end
