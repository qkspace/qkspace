class Session < ApplicationRecord
  belongs_to :user, inverse_of: :sessions, optional: true

  validates :timeout_at,
            :expires_at,
    presence: true

  before_validation :set_defaults

  scope :live, -> {
    now = Time.current

    where('timeout_at > ?', now).
      where('expires_at > ?', now).
      where('active')
  }

  def live?
    now = Time.current

    timeout_at > now &&
      expires_at > now &&
      active?
  end

  private

  def set_defaults
    # How long can a user use this session
    self.expires_at ||= 1.year.from_now

    # How long can a user use magic link
    self.timeout_at ||= 1.year.from_now
  end
end
