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
