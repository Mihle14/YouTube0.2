module Likes
  class ReactToPost
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
      return if @post.user == @user

      Notification.create!(
        user: @post.user,
        post: @post,
        notification_type: @like_type == "like" ? "liked" : "disliked",
        read: false
      )
    end
  end
end
