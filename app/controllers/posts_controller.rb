
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Posts::List.new(query: params[:query]).call.posts
  end

  def show
    Posts::TrackView.new(post: @post, user: current_user).call
    @comments = @post.comments.includes(:user, :replies)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Posts::Create.new(params: post_params, user: current_user).call.post
    Posts::Response.new(self, @post).call
  end

  def update
    @post = Posts::Update.new(post: @post, params: post_params).call.post
    Posts::Response.new(self, @post).call
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :video, :thumbnail)
  end
end
