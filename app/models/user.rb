# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :password, on: :create, presence: true
  validates :password, :email, presence: true, on: :create, if: proc { email.nil? || password.nil? }

  enum role: {
    member: 0,
    admin: 1
  }
end
# TODO: USER CANNOT UPDATE THEIR OWN ROLE
# TODO: USE PUNDIT TO LOCK USER OUT OF ATTRIBUTES
