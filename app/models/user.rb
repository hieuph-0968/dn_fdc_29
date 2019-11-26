class User < ApplicationRecord
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
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.min_password}
  def digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end
end
