module Likes
  class ReactionsToPost
    def initialize(post:, user:, like_type:)
      @post = post
      @user = user
      @like_type = like_type
    end

    def call
      raise ArgumentError, "Invalid reaction" unless %w[like dislike].include?(@like_type)

      like = @post.likes.find_or_initialize_by(user: @user)
      like.update!(like_type: @like_type)

      create_notification_if_needed
      like
    end

    private

    def create_notification_if_needed
      return if @post.user == @user

      Notification.find_or_create_by!(
        user: @post.user,
        post: @post,
        notification_type: notification_type
      ) do |notification|
        notification.read = false
      end
    end

    def notification_type
      @like_type == "like" ? "liked" : "disliked"
    end
  end
end
