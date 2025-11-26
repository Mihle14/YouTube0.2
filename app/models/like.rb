class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: [:post_id, :like_type], message: "has already liked/disliked this post" }
end
