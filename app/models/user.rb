# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: {
    member: 0,
    admin: 1
  }
end
