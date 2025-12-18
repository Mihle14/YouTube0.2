# Handles the destruction of comments
module Comments

  # Service object to destroy the given comments
  class Destroy
    attr_reader :comment

    def initialize(comment:)
      @comment = comment
    end

    def call
      comment.destroy
      self
    end
  end
end
