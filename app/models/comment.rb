class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :creator, class_name: 'User'
  belongs_to :meal

  validates :body, length: {minimum: 2}

end
