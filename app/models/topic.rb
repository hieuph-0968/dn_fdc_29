class Topic < ApplicationRecord
  has_many :suggests, dependent: :destroy
  has_many :posts, dependent: :destroy
end
