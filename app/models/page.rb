require 'github/markup'

class Page < ApplicationRecord
  belongs_to :project

  scope :ordered, -> { order(:position) }

  validates :title, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  before_destroy :validate_onliness

  before_save :markup

  acts_as_sortable

  def generate_slug
    self.slug = I18n.transliterate(title).parameterize
  end

  def markup
    self.html = GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, source)
  end

  def to_param
    slug
  end

  def validate_onliness
    throw :abort if only_page?
  end

  def only_page?
    project.pages.count == 1
  end
end
