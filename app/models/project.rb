class Project < ApplicationRecord
  has_many :pages, dependent: :destroy

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }, uniqueness: true

  before_create :generate_first_page

  def generate_first_page
    pages.build(title: title)
  end
end
