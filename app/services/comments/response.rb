# Handles controller responses for comment actions
module Comments

  # Service object to handle controller responses for comment actions,
  # using both HTML and Turbo Stream formats.
  class Response
    def initialize(controller, comment)
      @controller = controller
      @comment = comment
    end

    def call
      @controller.respond_to do |format|
        format.html { handle_html }
        format.turbo_stream { handle_turbo }
      end
    end

    private

    def persisted_or_valid?
      @comment.persisted? || @comment.errors.empty?
    end

    def handle_html
      if persisted_or_valid?
        @controller.redirect_to @comment.post, notice: "Comment was successfully saved."
      else
        @controller.render @controller.action_name.to_sym, status: :unprocessable_entity
      end
    end

    def handle_turbo
      stream = @controller.turbo_stream

      target, partial =
        if persisted_or_valid?
          [@comment, "comments/comment"]
        else
          ["comment_form_#{@comment.id || 'new'}", "comments/form"]
        end

      stream.replace(
        target,
        partial: partial,
        locals: { comment: @comment }
      )
    end
  end
end

