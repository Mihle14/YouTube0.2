class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: [:show, :edit, :update]

  def show
    @posts = @channel.posts.order(created_at: :desc)
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.build_channel(channel_params)
    if @channel.save
      redirect_to @channel, notice: "Channel created successfully."
    else
      render :new
    end
  end

  def edit
    redirect_to root_path unless current_user == @channel.user
  end

  def update
    if @channel.update(channel_params)
      redirect_to @channel, notice: "Channel updated!"
    else
      render :edit
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :avatar, :banner)
  end
end
