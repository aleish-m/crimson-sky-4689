class Ingredient < ApplicationRecord
  validates_presence_of :name, :calories
  has_many :dish_ingredients
  has_many :dishes, through: :dish_ingredients

  def self.favorite_ingredient(chef_id)
    joins(dishes:[:chef])
    .where(chefs: {id: chef_id})
    .group(:id)
    .select('ingredients.*, count(ingredients.id) as ingredient_count')
    .order(ingredient_count: :desc)
    .first
  end
end