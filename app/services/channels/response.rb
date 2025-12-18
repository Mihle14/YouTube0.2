# Handles controller responses for channel actions
module Channels

  # Service object that handles controller responses for channel actions
  class Response
    def initialize(controller, channel)
      @controller = controller
      @channel = channel
    end

    def call
      @controller.respond_to do |format|
        format.html do
          if @channel.persisted? || @channel.errors.empty?
            @controller.redirect_to @channel, notice: "Channel saved successfully."
          else
            @controller.render @controller.action_name.to_sym, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
