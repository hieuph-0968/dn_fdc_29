class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  enum role: {comment: 0, report: 1}
  validates :user_id, presence: true
  validates :post_id, presence: true
end
