class User < ApplicationRecord
  api_guard_associations refresh_token: 'refresh_tokens'
  has_many :refresh_tokens, dependent: :delete_all

  # Need to add :zxcvbnable as soon as the argument error is fixed
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # def weak_words
  #   ['gradebooklet', self.username]
  # end

  def authenticate(password)
    valid_password?(password)
  end

  validates :username, presence: true, uniqueness: true

  validates :email, 'valid_email_2/email': { mx: true, disposable: true, disallow_subaddressing: true}

end
