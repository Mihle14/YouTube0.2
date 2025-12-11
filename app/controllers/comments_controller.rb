class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      if @post.user && @post.user != current_user
        Notification.create!(user: @post.user, post: @post, notification_type: "commented", read: false)
      end

      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: "Comment added!" }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: "Failed to add comment." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "comments/form", locals: { comment: @comment }) }
      end
    end
  end


  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment deleted!" }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
