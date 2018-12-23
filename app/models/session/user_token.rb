class Session::UserToken < Session
  validates :token, :user, presence: true

  def self.find_for_login!(token)
    live.where(token: token).first!
  end

  private

  def set_defaults
    super

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
