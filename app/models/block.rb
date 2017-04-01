require 'github/markup'

class Block < ApplicationRecord
  belongs_to :page

  before_save :markup

  def markup
    self.html = GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, source)
  end
end
