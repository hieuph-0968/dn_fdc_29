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
end
