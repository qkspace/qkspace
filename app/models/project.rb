class Project < ApplicationRecord
  belongs_to :user
  has_many :pages, dependent: :delete_all

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }, uniqueness: true

  before_create :generate_first_page

  def generate_first_page
    pages.build(title: title)
  end
end
