class Post < ActiveRecord::Base
  # has_many :votes, as: :voteable
  include Voteable
  include Slugable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 3}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  def slug_input
    self.title
  end
end
