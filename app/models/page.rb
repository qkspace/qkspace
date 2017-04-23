class Page < ApplicationRecord
  belongs_to :project
  has_many :blocks, dependent: :destroy

  validates :title, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  before_destroy :validate_onliness

  acts_as_sortable

  def generate_slug
    self.slug = I18n.transliterate(title).parameterize
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
