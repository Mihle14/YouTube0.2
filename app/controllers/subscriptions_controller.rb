class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel

  def create
    current_user.subscriptions.create(channel: @channel)
    render partial: "subscriptions/button", locals: { channel: @channel }
  end

  def destroy
    subscription = current_user.subscriptions.find_by(channel: @channel)
    subscription&.destroy
    render partial: "subscriptions/button", locals: { channel: @channel }
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end
end
