class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # Notify the post owner (like YouTube), but NOT if you're commenting on your own post
      if @post.user != current_user
        Notification.create!(
          user: @post.user,
          post: @post,
          message: "#{current_user.email} commented on your post",
          read: false
        )
      end

      redirect_to post_path(@post), notice: "Comment added!"
    else
      redirect_to post_path(@post), alert: "Failed to add comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
