# Represents a user's subscription to a channel, 
# ensuring uniqueness per user and channel

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :user_id, uniqueness: { scope: :channel_id }
end
