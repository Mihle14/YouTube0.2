# Service object to remove a user's like or reaction from a post

module Likes
  class DestroyReaction
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      @post.likes.find_by(user: @user)&.destroy
    end
  end
end
