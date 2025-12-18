# Handles user reactions (like/dislike) to posts
module Likes

  # Service object to handle a user's like or dislike on a post,
  # updating the like/dislike type and 
  # creating a notification for the post owner.
  class ReactionsToPost
    def initialize(post:, user:, like_type:)
      @post = post
      @user = user
      @like_type = like_type
    end

    def call
      like = @post.likes.find_or_initialize_by(user: @user)
      like.update!(like_type: @like_type)

      create_notification_if_needed
      like
    end

    private

    def create_notification_if_needed
      post_owner = @post.user
      return if post_owner == @user

      Notification.find_or_create_by!(
        user: post_owner,
        post: @post,
        notification_type: notification_type
      ) { |notification| notification.read = false }
    end

    def notification_type
      @like_type == "like" ? "liked" : "disliked"
    end
  end
end
