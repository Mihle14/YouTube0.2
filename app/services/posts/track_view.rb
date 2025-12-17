module Posts
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
