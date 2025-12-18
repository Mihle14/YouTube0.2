# Handles the creation of a channel for a given user
module Users

  # Service object to create a channel for a user after signup
  class CreateChannel
    def initialize(user)
      @user = user
    end

    def call
      @user.create_channel!(
        name: @user.name || "Channel #{@user.id}"
      )
    end
  end
end