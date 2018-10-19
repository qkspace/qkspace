class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :pages, -> { ordered }, dependent: :delete_all
  has_many :project_collaborations, dependent: :destroy
  has_many :collaborators, through: :project_collaborations, source: :user

  scope :editable_by, -> (user_id) {
    left_joins(:project_collaborations)
    .where("projects.user_id = :id OR project_collaborations.user_id = :id", id: user_id)
  }

  SLUG_BLACK_LIST = %w[about admin api billing blog buy demo dev download email faq ftp help
                       imap mail me my pop pop3 pricing sftp shop smtp staging support wiki
                       ww www wwww].freeze

  before_validation :generate_first_page, on: :create

  validates_associated :pages, on: :create

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }, uniqueness: true,
                   length: { minimum: 4 }, exclusion: { in: SLUG_BLACK_LIST }

  validates :google_analytics_tracker_id,
    format: { with: /\AUA-\d*-\d*\z/, allow_blank: true }

  def generate_first_page
    pages.build(title: title, source: '')
  end
end
