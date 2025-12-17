module Comments
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
