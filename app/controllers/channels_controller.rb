# Handles CRUD actions for channels

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
    @channel = Channels::Create.new(user: current_user, params: channel_params).call.channel
    Channels::Response.new(self, @channel).call(:create)
  end

  def edit
    redirect_to root_path unless current_user == @channel.user
  end

  def update
    @channel = Channels::Update.new(channel: @channel, params: channel_params).call.channel
    Channels::Response.new(self, @channel).call(:update)
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :avatar, :banner)
  end
end
