class User < ActiveRecord::Base
  has_secure_password
  validates :password, :password_confirmation, presence: true
  validates :name, presence: true
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: true

  has_many :secrets
  has_many :likes, dependent: :destroy
  # has_many :secrets, through: :likes as: :secrets_liked
end
