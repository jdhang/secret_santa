class User < ActiveRecord::Base
  has_many :items
  
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, on: :create, presence: true, length: { minimum: 4}
end