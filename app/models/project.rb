class Project < ApplicationRecord
  belongs_to :user
  has_many :pages, -> { ordered }, dependent: :delete_all

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }, uniqueness: true
  validates :google_analytics_tracker_id, format: { with: /\AUA-\d*-\d*\z/ }

  before_create :generate_first_page

  def generate_first_page
    pages.build(title: title, source: '')
  end
end
