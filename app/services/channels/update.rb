module Channels
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
