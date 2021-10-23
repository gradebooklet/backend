class User < ApplicationRecord
  api_guard_associations refresh_token: 'refresh_tokens'
  has_many :refresh_tokens, dependent: :delete_all

  # Need to add :zxcvbnable as soon as the argument error is fixed
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  validates :email, 'valid_email_2/email': { mx: true, disposable: true, disallow_subaddressing: true}

  def authenticate(password)
    valid_password?(password)
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    sent_at = self.reset_password_sent_at

    return false if sent_at.nil?

    (sent_at + 4.hours) > Time.now.utc
  end

  private

  def generate_token
    SecureRandom.hex(15)
  end
end
