class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :pages, -> { ordered }, dependent: :delete_all, inverse_of: :project
  has_many :collaborations, class_name: "ProjectCollaboration", dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user

  scope :editable_by, -> (user_id) {
    left_joins(:collaborations)
      .where("projects.user_id = :id OR project_collaborations.user_id = :id", id: user_id)
  }

  SLUG_BLACK_LIST = %w[about admin api billing blog buy demo dev download email faq ftp help
                       imap mail me my pop pop3 pricing sftp shop smtp staging support wiki
                       ww www wwww].freeze

  before_validation :generate_first_page, on: :create
  before_validation :downcase_slug
  before_validation :set_secret_token

  validates_associated :pages, on: :create

  validates :domain,
    # x.x.x.x.x.x – where each "x" is 1-63 chars
    format: { with: /\A([[:alnum:]\-]{1,63}\.)+[[:alnum:]\-]{1,63}\z/ },
    length: { maximum: 253 },
    allow_blank: true

  validates :title, :slug, presence: true
  validates :slug, format: { with: /\A[a-z][a-z0-9-]+\z/ }, uniqueness: true,
                   length: { minimum: 4 }, exclusion: { in: SLUG_BLACK_LIST }

  validates :google_analytics_tracker_id,
    format: { with: /\AUA-\d*-\d*\z/, allow_blank: true }

  validates :google_remarketing_tracker_id,
    format: { with: /\AAW-\d*\z/, allow_blank: true }

  def generate_first_page
    pages.build(title: title, source: '')
  end

  private

  def downcase_slug
    self.slug &&= slug.downcase
  end

  def set_secret_token
    unless self.private
      self.secret_token = ""
      return
    end

    if self.private_changed? || self.secret_enabled_changed?
      self.secret_token = SecureRandom.urlsafe_base64(32)
    end
  end
end
