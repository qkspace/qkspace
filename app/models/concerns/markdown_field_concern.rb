module MarkdownFieldConcern
  extend ActiveSupport::Concern

  included do
    before_save :markup
  end

  private

  def markup
    node = CommonMarker.render_doc(source, :DEFAULT)
    renderer = HeadersRenderer.new
    self.html = renderer.render(node)
  end
end
