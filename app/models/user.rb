class User < ApplicationRecord
  # User has many comments
  has_many :comments, dependent: :destroy
  has_many :videos, through: :comments
  has_many :likes
  has_secure_password
end
