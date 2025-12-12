class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
  like_type = params[:like_type]

  @like = @post.likes.find_or_initialize_by(user: current_user)
  @like.like_type = like_type
  @like.save!

  if @post.user && @post.user != current_user
    case like_type
    when "like"
      Notification.create!(
        user: @post.user,
        post: @post,
        notification_type: "liked",
        read: false
      )
      flash[:notice] = "Someone liked your post!"
    when "dislike"
      Notification.create!(
        user: @post.user,
        post: @post,
        notification_type: "disliked",
        read: false
      )
      flash[:notice] = "Someone disliked your post!"
    end
  end

  respond_to do |format|
    format.html { redirect_to @post }
    format.turbo_stream do
      broadcast_reaction_counts
      replace_user_reaction_buttons
    end
  end
end


  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like&.destroy

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
