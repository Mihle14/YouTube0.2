module Posts
  class Response
    def initialize(controller, post)
      @controller = controller
      @post = post
    end

    def call
      @controller.respond_to do |format|
        if @post.persisted? || @post.errors.empty?
          format.html { @controller.redirect_to @post, notice: "Post was successfully saved." }
          format.json { @controller.render :show, status: :ok, location: @post }
        else
          format.html { @controller.render @controller.action_name == 'create' ? :new : :edit, status: :unprocessable_entity }
          format.json { @controller.render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
