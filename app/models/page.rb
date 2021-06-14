require 'commonmarker/headers_renderer'

class Page < ApplicationRecord
  belongs_to :project, inverse_of: :pages

  scope :ordered, -> { ordered_by_position_asc }

  validates :title, :slug, presence: true
  validates :slug, uniqueness: { scope: :project_id }

  before_validation :generate_slug
  after_validation :transfer_slug_error_to_title

  before_destroy :validate_onliness

  before_save :markup

  acts_as_sortable do |config|
    config[:relation] = ->(instance) { instance.project.pages }
    config[:append] = true
  end

  def only_page?
    project.pages.count == 1
  end

  private

  def generate_slug
    self.slug = I18n.transliterate(title.to_s, locale: :ru).parameterize.presence
  end

  def markup
    node = CommonMarker.render_doc(source, :DEFAULT, %i[table autolink])
    renderer = HeadersRenderer.new
    self.html = renderer.render(node)
  end

  def validate_onliness
    throw :abort if only_page?
  end

  def transfer_slug_error_to_title
    errors[:slug].each do |error|
      errors.add(:title, error)
    end
  end
end
