class Category < ActiveRecord::Base
  include SluggableNolly

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  sluggable_column :name

  # def slug_input
  #   self.name
  # end
end
