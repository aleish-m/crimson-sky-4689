require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it { should belong_to :chef }
    it { should have_many(:dish_ingredients) } 
    it { should have_many(:ingredients).through(:dish_ingredients) } 
  end

  describe 'instance methods' do
    before :each do
        @chef_1 = Chef.create!(name: "John")
        @chef_2 = Chef.create!(name: "Annie")

        @dish_1 = @chef_1.dishes.create!(name: 'Pulled Pork', description: 'Pulled pork sandwich')
        @dish_2 = @chef_2.dishes.create!(name: 'Chicken Saltamiboca', description: 'Chicken in a Lemon sauce with Pasta')


        @pork = Ingredient.create!(name: 'Pork', calories: 50 )
        @bbq_sauce = Ingredient.create!(name: 'BBQ Sauce', calories: 100 )
        @bun = Ingredient.create!(name: 'Hamburger Bun', calories: 150 )

        @chicken = Ingredient.create!(name: 'Chicken', calories: 50 )
        @pasta = Ingredient.create!(name: 'Angel Hair Pasta', calories: 300 )
        @lemon = Ingredient.create!(name: 'Lemon', calories: 10 )
        @white_wine = Ingredient.create!(name: 'White Wine', calories: 80 )

        @dish_1.ingredients << @pork
        @dish_1.ingredients << @bbq_sauce
        @dish_1.ingredients << @bun

        @dish_2.ingredients << @chicken
        @dish_2.ingredients << @pasta
        @dish_2.ingredients << @lemon
        @dish_2.ingredients << @white_wine
      end

    it "#calorie_count" do
      expect(@dish_1.calorie_count).to eq(300)
      expect(@dish_2.calorie_count).to eq(440)
    end
  end
end