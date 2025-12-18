# Handles controller responses for like/dislike actions
module Likes

  # Service object to handle controller responses for like/dislike actions,
  # using HTML redirect and Turbo Stream updates for reaction counts.
  class Response
    def initialize(controller, post)
      @controller = controller
      @post = post
    end

    def call
      @controller.respond_to do |format|
        format.html { @controller.redirect_to @post }
        format.turbo_stream do
          broadcast_reaction_counts
          replace_user_reaction_buttons
        end
      end
    end

    private

    def broadcast_reaction_counts
      Turbo::StreamsChannel.broadcast_replace_to(
        "post_#{@post.id}_reactions",
        target: @controller.helpers.dom_id(@post, :reactions),
        partial: "posts/reactions",
        locals: { post: @post }
      )
    end

    def replace_user_reaction_buttons
      @controller.render turbo_stream: turbo_stream.replace(
        "reaction_buttons_#{@post.id}_#{@controller.current_user.id}",
        partial: "posts/reaction_buttons",
        locals: { post: @post }
      )
    end
  end
end
