require 'rails_helper'

RSpec.describe "Dish show page" do
  describe "As a visitor" do
    describe "When I visit a dish's show page" do
      before :each do
        @chef_1 = Chef.create!(name: "John")
        @chef_2 = Chef.create!(name: "Annie")

        @dish_1 = @chef_1.dishes.create!(name: 'Pulled Pork', description: 'Pulled pork sandwich')
        @dish_2 = @chef_2.dishes.create!(name: 'Chicken Saltamiboca', description: 'Chicken in a Lemon sauce with Pasta')
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
          expect(page).to have_content(@dish_2.chef.name)
        end
      end

    end
  end
end