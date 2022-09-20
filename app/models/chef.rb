class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredients_used
    dishes.joins(:ingredients).select('ingredients.*')
  end
end