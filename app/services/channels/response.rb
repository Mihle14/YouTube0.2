module Channels
  class Response
    def initialize(controller, channel)
      @controller = controller
      @channel = channel
    end

    def call(action = :create)
      @controller.respond_to do |format|
        if @channel.persisted? || @channel.errors.empty?
          format.html { @controller.redirect_to @channel, notice: "Channel #{action}d successfully." }
        else
          format.html { @controller.render action == :create ? :new : :edit, status: :unprocessable_entity }
        end
      end
    end
  end
end
