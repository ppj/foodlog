class User < ActiveRecord::Base
  include Slugable
  set_slug_column_to :username

  has_many :meals, dependent: :destroy
  has_secure_password validations: false

  validates :username, length: {minimum: 3}, uniqueness: true
  validates :password, on: :create, length: {minimum: 3}
  validates :email, uniqueness: true

end
