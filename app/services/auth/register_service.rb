# frozen_string_literal: true

module Auth
  class RegisterService
    def initialize(params:)
      @username = params[:username]
      @password = params[:password]
      @email = params[:email]
    end

    def perform
      register_user
    end

    private

    def register_user
      user = User.find_by(username: @username)
      duplicate_user unless user.nil?

      user = User.new(username: @username, password: hashed_password, email: @email)
      if user.save
        user
      else
        raise CustomErrors::UserCreationError
      end
    end

    def hashed_password
      Digest::SHA2.hexdigest @password
    end

    def duplicate_user
      raise CustomErrors::DuplicateUser
    end
  end
end
