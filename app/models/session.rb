class Session < ApplicationRecord
  belongs_to :user, inverse_of: :sessions

  validates :timeout_at,
            :expires_at,
            :token,
    presence: true

  before_validation :set_defaults

  scope :live, -> {
    now = Time.current

    where('timeout_at > ?', now).
      where('expires_at > ?', now).
      where('active')
  }

  def find_for_token_login!(token)
    live.where(token: params[:token]).first!
  end

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

    self.token ||=
      loop do
        token = generate_token
        break token unless Session.where(token: token).exists?
      end
  end

  def generate_token
    SecureRandom.urlsafe_base64(32)
  end
end
