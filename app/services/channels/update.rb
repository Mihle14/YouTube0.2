# Handles the updating of existing channels
module Channels

  # Service object that updates an existing channel with given parameters
  class Update
    attr_reader :channel

    def initialize(channel:, params:)
      @channel = channel
      @params = params
    end

    def call
      channel.update(@params)
      self
    end

    def success?
      channel.errors.empty?
    end
  end
end
