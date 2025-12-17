class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    Likes::ReactionsToPost.new(
      post: @post,
      user: current_user,
      like_type: params[:like_type]
    ).call

    Likes::Response.new(self, @post).call
  rescue ArgumentError
    redirect_to @post, alert: "Invalid reaction"
  end

  def destroy
    Likes::DestroyReaction.new(post: @post, user: current_user).call
    Likes::Response.new(self, @post).call
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end