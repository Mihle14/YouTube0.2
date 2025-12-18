# Service object to handle controller responses for post actions,
# using HTML redirects and JSON responses and is error handling.

module Posts
  class Response
    def initialize(controller, post)
      @controller = controller
      @post = post
    end

    def call
      errors = @post.errors
      persisted_or_valid = @post.persisted? || errors.empty?

      @controller.respond_to do |format|
        format.html do
          if persisted_or_valid
            @controller.redirect_to @post, notice: "Post was successfully saved."
          else
            action = @controller.action_name.to_sym
            @controller.render action, status: :unprocessable_entity
          end
        end

        format.json do
          if persisted_or_valid
            @controller.render :show, status: :ok, location: @post
          else
            @controller.render json: errors, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
