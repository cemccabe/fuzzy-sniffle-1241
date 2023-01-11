require 'rails_helper'

RSpec.describe 'Chef show page' do
  before(:each) do
    @gordon = Chef.create!(name: 'Gordon Ramsay')
    @sushi = @gordon.dishes.create!(name: 'Sushi', description: 'Japanese dish')
    @salad = @gordon.dishes.create!(name: 'Salad', description: 'Healthy appetizer')
    @rice = Ingredient.create!(name: 'Rice', calories: 200)
    @salmon = Ingredient.create!(name: 'Salmon', calories: 150)
    @lettuce = Ingredient.create!(name: 'Lettuce', calories: 30)
    @dressing = Ingredient.create!(name: 'Dressing', calories: 250)
    DishIngredient.create!(dish_id: @sushi.id, ingredient_id: @rice.id)
    DishIngredient.create!(dish_id: @sushi.id, ingredient_id: @salmon.id)
    DishIngredient.create!(dish_id: @salad.id, ingredient_id: @lettuce.id)
    DishIngredient.create!(dish_id: @salad.id, ingredient_id: @dressing.id)

    @emeril = Chef.create!(name: 'Emeril Lagasse')

    @steak = Dish.create!(name: 'Steak and Potatoes', description: 'Classic meal', chef_id: @emeril.id)
    @beef = Ingredient.create!(name: 'Beef', calories: 500)
    @potatoes = Ingredient.create!(name: 'Potatoes', calories: 425)
    DishIngredient.create!(dish_id: @steak.id, ingredient_id: @beef.id)
    DishIngredient.create!(dish_id: @steak.id, ingredient_id: @potatoes.id)

    visit chef_path(@gordon)
  end

  describe 'User Story #2' do
    it 'I see the name of that chef' do
      expect(page).to have_content(@gordon.name)
    end

    it 'and I see a list of all dishes that belong to that chef' do
      expect(page).to have_content(@sushi.name)
      expect(page).to have_content(@salad.name)
    end

    it 'and I see a form to add an existing dish to that chef' do
      expect(page).to have_field('dish_id')
    end

    it 'When I fill in the form with the ID of a dish that exists in the database And I click Submit' do
      fill_in('dish_id', with: "#{@salad.id}")
      click_button('Submit')
      expect(current_path).to eq(chef_path(@gordon))
      expect(page).to have_content(@salad.name)
    end
  end

  describe 'User Story #3' do
    it 'links all the ingredients that the chef uses' do
      expect(page).to have_link("#{@gordon.name} Ingredients")
      click_link("#{@gordon.name} Ingredients")
      expect(current_path).to eq(chef_ingredients_path(@gordon))
    end
  end



end