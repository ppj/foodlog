class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :commentable, polymorphic: true

  validates :body, length: {minimum: 2}

end
