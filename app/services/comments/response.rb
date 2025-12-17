module Comments
  class Response
    def initialize(controller, comment)
      @controller = controller
      @comment = comment
    end

    def call
      errors = @comment.errors
      persisted_or_valid = @comment.persisted? || errors.empty?
      action_name_sym = @controller.action_name.to_sym

      @controller.respond_to do |format|
        format.html do
          if persisted_or_valid
            @controller.redirect_to @comment.post, notice: "Comment was successfully saved."
          else
            @controller.render action_name_sym, status: :unprocessable_entity
          end
        end

        format.turbo_stream do
          if persisted_or_valid
            @controller.turbo_stream.replace(
              @comment,
              partial: "comments/comment",
              locals: { comment: @comment }
            )
          else
            @controller.turbo_stream.replace(
              "comment_form_#{@comment.id || 'new'}",
              partial: "comments/form",
              locals: { comment: @comment }
            )
          end
        end
      end
    end
  end
end

