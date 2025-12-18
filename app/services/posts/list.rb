# Service object to fetch a list of posts, filtered by a search query,
# ordered by creation date from ascending to descending order.

module Posts
  class List
    attr_reader :posts

    def initialize(query: nil)
      @query = query
    end

    def call
      @posts =
        if @query.present?
          Post.search(@query).order(created_at: :desc)
        else
          Post.order(created_at: :desc)
        end
      self
    end
  end
end
