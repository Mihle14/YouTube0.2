# Handles tracking views on posts
module Posts

  # Service object to track a view on a post.
  # Increments the post's view count and 
  # records the view for a specific user not the post owner though.
  class TrackView
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      @post.increment!(:views)
      return unless @user

      PostView.find_or_create_by!(user: @user, post: @post)
    end
  end
end
