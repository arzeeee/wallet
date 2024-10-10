# frozen_string_literal: true

class CustomErrors
  class InvalidCredentials < StandardError
    def initialize(msg = "Invalid Credentials")
      super
    end
  end

  class DuplicateUser < StandardError
    def initialize(msg = "Username is already taken")
      super
    end
  end

  class BalanceNotEnough < StandardError
     def initialize(msg = "Balance is not enough")
      super
    end
  end

  class UserNotFound < StandardError
    def initialize(msg = "Username is not found")
      super
    end
  end

  class AmountMustBePositive < StandardError
    def initialize(msg = "Amount must be greater than 0")
      super
    end
  end

  class SameUserTransfer < StandardError
    def initialize(msg = "Cannot transfer to the same user")
      super
    end
  end

  class InvalidBalance < StandardError
    def initialize(msg = "Invalid balance")
      super
    end
  end

  class InvalidStockAmount < StandardError
    def initialize(msg = "Invalid stock amount")
      super
    end
  end

  class UserCreationError < StandardError
    def initialize(msg = "Invalid email or username")
      super
    end
  end

  class InvalidQuantity < StandardError
    def initialize(msg = "Quantity must be positive")
      super
    end
  end
end
