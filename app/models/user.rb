class User < ApplicationRecord
  attr_accessor :reset_token
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_histories, dependent: :destroy
  has_many :active_messages, class_name: "Message",
                             foreign_key: :messager_id,
                             dependent: :destroy,
                             inverse_of: :user
  has_many :passive_messages, class_name: "Message",
                              foreign_key: :messaged_id,
                              dependent: :destroy,
                              inverse_of: :user
  has_many :messaging, through: :active_messages, source: :messaged
  has_many :messagers, through: :passive_messages, source: :messager
  enum role: {admin: 0, user: 1}
  before_save{email.downcase!}
  validates :name,  presence: true, length: {maximum: Settings.max_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: {maximum: Settings.max_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_password}, allow_nil: true
  has_secure_password

  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
    # Returns a random token.

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
end
