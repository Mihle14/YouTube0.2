class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comments::Create.new(post: @post, user: current_user, params: comment_params).call.comment
    Comments::Response.new(self, @comment, @post).call(:create)
  end

  def destroy
    Comments::Destroy.new(comment: @comment).call
    Comments::Response.new(self, @comment, @post).call(:destroy)
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
