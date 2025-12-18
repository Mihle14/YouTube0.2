# Handles the creation of a new post
module Posts

  # Service object to create a new post for a user, 
  # assigning ownership and channel.
  class Create
    attr_reader :post

    def initialize(params:, user:)
      @params = params
      @user = user
      @post = Post.new(@params)
    end

    def call
      assign_owner
      save_post
      self
    end

    def success?
      post.persisted?
    end

    private

    def assign_owner
      post.user = @user
      post.channel = @user.channel
    end

    def save_post
      post.save
    end
  end
end
