require 'github/markup'

class Page < ApplicationRecord
  belongs_to :project

  scope :ordered, -> { order(:position) }

  validates :title, :slug, presence: true
  validates :slug, uniqueness: { scope: :project_id }

  before_validation :generate_slug
  after_validation :transfer_slug_error_to_title

  before_destroy :validate_onliness

  before_save :markup

  acts_as_sortable do |config|
    config[:relation] = ->(instance) { instance.project.pages }
  end

  def only_page?
    project.pages.count == 1
  end

  private

  def generate_slug
    self.slug = I18n.transliterate(title)&.parameterize
  end

  def markup
    self.html = GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, source)
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
