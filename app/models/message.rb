class Message < ApplicationRecord
  belongs_to :messager, class_name: "User", inverse_of: :message
  belongs_to :messaged, class_name: "User", inverse_of: :message
  validates :messager_id, presence: true
  validates :messaged_id, presence: true
end
