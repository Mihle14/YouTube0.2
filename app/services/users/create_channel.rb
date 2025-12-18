module Users
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