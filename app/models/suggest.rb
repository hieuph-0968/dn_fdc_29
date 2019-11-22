class Suggest < ApplicationRecord
  belongs_to :topic
  validates :topic_id, presence: true
end
