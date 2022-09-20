require 'rails_helper'

RSpec.describe "Dish show page" do
  describe "As a visitor" do
    describe "When I visit a dish's show page" do
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

      it "I see the dish’s name and description" do
        visit dish_path(@dish_1)
        within("#dish-#{@dish_1.id}-info") do
          expect(page).to have_content(@dish_1.name)
          expect(page).to have_content(@dish_1.description)
          expect(page).to_not have_content(@dish_2.name)
          expect(page).to_not have_content(@dish_2.description)
        end
      end

      it "I see a list of ingredients for that dish" do
        visit dish_path(@dish_1)
        
        within("#dish-#{@dish_1.id}-ingredients") do
          @dish_1.ingredients.each do |ingredient|
            expect(page).to have_content(ingredient.name)
            expect(page).to_not have_content(@dish_2.ingredients.any?{|ingredient| ingredient.name})
          end
        end
      end

      it "I see the chef's name" do
        visit dish_path(@dish_1)

        within("#dish-#{@dish_1.id}-info") do
          expect(page).to have_content(@dish_1.chef.name)
          expect(page).to_not have_content(@dish_2.chef.name)
        end
      end

      it "I see the total calorie count for that dish" do
        visit dish_path(@dish_1)

        within("#dish-#{@dish_1.id}-info") do
          expect(page).to have_content(@dish_1.calorie_count)
          expect(page).to_not have_content(@dish_2.calorie_count)
        end
      end

    end
  end
end