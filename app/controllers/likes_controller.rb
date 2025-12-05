class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like_type = params[:like_type]
    @like = @post.likes.find_or_initialize_by(user: current_user)
    @like.like_type = like_type
    @like.save!
    if like_type == "like" && @post.user && @post.user != current_user
      Notification.create!(
        user: @post.user,
        post: @post,
        notification_type: "liked",
        read: false
      )

      flash[:alert] = "Someone liked your post!"
    end

    redirect_to @post
  end
end
