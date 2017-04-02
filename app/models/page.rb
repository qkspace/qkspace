class Page < ApplicationRecord
  belongs_to :project
  has_many :blocks, dependent: :destroy

  validates :title, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = I18n.transliterate(title).parameterize
  end

  def to_param
    slug
  end
end
