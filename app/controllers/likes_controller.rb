class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    Likes::ReactionsToPost.new(
      post: @post,
      user: current_user,
      like_type: params[:like_type]
    ).call

    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream do
        broadcast_reaction_counts
        replace_user_reaction_buttons
      end
    end
  rescue ArgumentError
    redirect_to @post, alert: "Invalid reaction"
  end

  def destroy
    @post.likes.find_by(user: current_user)&.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream do
        broadcast_reaction_counts
        replace_user_reaction_buttons
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def broadcast_reaction_counts
    Turbo::StreamsChannel.broadcast_replace_to(
      "post_#{@post.id}_reactions",
      target: helpers.dom_id(@post, :reactions),
      partial: "posts/reactions",
      locals: { post: @post }
    )
  end

  def replace_user_reaction_buttons
    render turbo_stream: turbo_stream.replace(
      "reaction_buttons_#{@post.id}_#{current_user.id}",
      partial: "posts/reaction_buttons",
      locals: { post: @post }
    )
  end
end
