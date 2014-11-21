class User < ActiveRecord::Base
  include Slugable
  set_slug_column_to :username

  has_many :meals, dependent: :destroy
  has_many :foods
  has_secure_password validations: false
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :username, length: {minimum: 3}, uniqueness: true
  validates :password, on: :create, length: {minimum: 3}
  validates :email, uniqueness: true

  def admin?
    self.role == 'admin'
  end

end
