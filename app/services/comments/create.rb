# Service object to create new comments for posts by users

module Comments
  class Create
    attr_reader :comment

    def initialize(post:, user:, params:)
      @post = post
      @user = user
      @params = params
      @comment = post.comments.new(@params)
    end

    def call
      assign_user
      comment.save
      self
    end

    def success?
      comment.persisted?
    end

    private

    def assign_user
      comment.user = @user
    end
  end
end
