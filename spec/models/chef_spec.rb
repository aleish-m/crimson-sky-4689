require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe "instance methods" do
    before :each do
      @chef_1 = Chef.create!(name: "John")
      @chef_2 = Chef.create!(name: "Annie")

      @dish_1 = @chef_1.dishes.create!(name: 'Pulled Pork', description: 'Pulled pork sandwich')
      @dish_2 = @chef_1.dishes.create!(name: 'Buffalo Chicken Cups', description: 'Shredded Chicken in Buffalo Wing Sauce and Ranch with cheese in Wonton Wrapers')
      @dish_3 = @chef_2.dishes.create!(name: 'Chicken Saltamiboca', description: 'Chicken in a Lemon sauce with Pasta')


      @pork = Ingredient.create!(name: 'Pork', calories: 50 )
      @bbq_sauce = Ingredient.create!(name: 'BBQ Sauce', calories: 100 )
      @bun = Ingredient.create!(name: 'Hamburger Bun', calories: 150 )

      @cheese = Ingredient.create!(name: 'Cheese', calories: 150 )
      @wing_sauce = Ingredient.create!(name: 'Buffalo Wing Sauce', calories: 80 )
      @wonton = Ingredient.create!(name: 'Wonton Wrapers', calories: 20 )
      @ranch = Ingredient.create!(name: 'Ranch Dressing', calories: 180 )

      @chicken = Ingredient.create!(name: 'Chicken', calories: 50 )
      @pasta = Ingredient.create!(name: 'Angel Hair Pasta', calories: 300 )
      @lemon = Ingredient.create!(name: 'Lemon', calories: 10 )
      @white_wine = Ingredient.create!(name: 'White Wine', calories: 80 )

      @dish_1.ingredients << @pork
      @dish_1.ingredients << @bbq_sauce
      @dish_1.ingredients << @bun

      @dish_2.ingredients << @chicken
      @dish_2.ingredients << @cheese
      @dish_2.ingredients << @wing_sauce
      @dish_2.ingredients << @wonton
      @dish_2.ingredients << @ranch

      @dish_3.ingredients << @chicken
      @dish_3.ingredients << @pasta
      @dish_3.ingredients << @lemon
      @dish_3.ingredients << @white_wine
    end

    it "#ingredients_used" do
      # require "pry"; binding.pry
      expect(@chef_1.ingredients_used.pluck('ingredients.name')).to include(@pork.name, @bbq_sauce.name, @bun.name, @chicken.name, @cheese.name, @wing_sauce.name, @wonton.name, @ranch.name)
      expect(@chef_2.ingredients_used.pluck('ingredients.name')).to include(@chicken.name, @pasta.name, @lemon.name, @white_wine.name)
    end
  end
end