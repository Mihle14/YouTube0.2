# Records that a user has viewed a specific post

class PostView < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
