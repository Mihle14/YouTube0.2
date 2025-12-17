module Comments
  class Response
    def initialize(controller, comment, post)
      @controller = controller
      @comment = comment
      @post = post
    end

    def call(action)
      @controller.respond_to do |format|
        if action == :create && @comment.persisted?
          format.html { @controller.redirect_to @post, notice: "Comment added!" }
          format.turbo_stream
        elsif action == :create
          format.html { @controller.redirect_to @post, alert: "Failed to add comment." }
        elsif action == :destroy
          format.html { @controller.redirect_to @post, notice: "Comment deleted!" }
          format.turbo_stream
        end
      end
    end
  end
end
