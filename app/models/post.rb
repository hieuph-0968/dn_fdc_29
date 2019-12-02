class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :user_id, presence: true
  validates :topic_id, presence: true

  scope :count_post_by_topic, (lambda do |topic_id|
    where(topic_id: topic_id).count
  end)
end
