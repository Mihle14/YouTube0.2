# Service object to update an existing post with given parameters.
# success? method to check if the update was successful.

module Posts
  class Update
    attr_reader :post

    def initialize(post:, params:)
      @post = post
      @params = params
    end

    def call
      post.update(@params)
      self
    end

    def success?
      post.errors.empty?
    end
  end
end
