require 'rails_helper'

RSpec.describe "Chef show page" do
  describe "As a visitor" do
    describe "When I visit a chef's show page" do
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

      it "I see the name of that chef" do
        visit chef_path(@chef_1)

        within("#chef-#{@chef_1.id}-info") do
          expect(page).to have_content(@chef_1.name)
          expect(page).to_not have_content(@chef_2.name)
        end
      end

      it "I see a link to view a list of all ingredients that this chef uses in their dishes, When I click on that link I'm taken to a chef's ingredient index page" do
        visit chef_path(@chef_1)

        within("#chef-#{@chef_1.id}-info") do
          click_link "Veiw #{@chef_1.name}'s Ingredients"
        end
        expect(current_path).to eq chef_ingredients_path(@chef_1)
      end

      it "I can see a unique list of names of all the ingredients that this chef uses" do
        visit chef_ingredients_path(@chef_1)

        within("#ingredients-chef-#{@chef_1.id}") do
          @dish_1.ingredients.each do |ingredient|
            expect(page).to have_content(ingredient.name)
          end
          @dish_2.ingredients.each do |ingredient|
            expect(page).to have_content(ingredient.name)
          end
        end 
      end
    end
  end
end
