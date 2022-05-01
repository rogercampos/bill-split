class Bill < ApplicationRecord
  before_create do
    self.public_token = SecureRandom.hex 64
    self.data = []
  end
end
