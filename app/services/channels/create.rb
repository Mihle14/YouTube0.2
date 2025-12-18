# Handles the creation of new channels for users
module Channels

  # Service object to create new channels for users
  class Create
    attr_reader :channel

    def initialize(user:, params:)
      @user = user
      @params = params
      @channel = user.build_channel(@params)
    end

    def call
      channel.save
      self
    end

    def success?
      channel.persisted?
    end
  end
end
