class Project < ApplicationRecord
  belongs_to :user
  has_many :pages, -> { ordered }, dependent: :delete_all

  before_validation :generate_first_page, on: :create

  validates_associated :pages, on: :create

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }, uniqueness: true

  validates :google_analytics_tracker_id,
    format: { with: /\AUA-\d*-\d*\z/, allow_blank: true }

  def generate_first_page
    pages.build(title: title, source: '')
  end
end
