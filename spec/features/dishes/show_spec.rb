require 'rails_helper'

RSpec.describe 'Dish show page' do
  before(:each) do
    @gordon = Chef.create!(name: 'Gordon Ramsay')
    @sushi = @gordon.dishes.create!(name: 'Sushi', description: 'Japanese dish')
    @rice = Ingredient.create!(name: 'Rice', calories: 200)
    @salmon = Ingredient.create!(name: 'Salmon', calories: 150)
    DishIngredient.create!(dish_id: @sushi.id, ingredient_id: @rice.id)
    DishIngredient.create!(dish_id: @sushi.id, ingredient_id: @salmon.id)

    @emeril = Chef.create!(name: 'Emeril Lagasse')
    @salad = @emeril.dishes.create!(name: 'Salad', description: 'Healthy appetizer')
    @lettuce = Ingredient.create!(name: 'Lettuce', calories: 30)
    @dressing = Ingredient.create!(name: 'Dressing', calories: 250)
    DishIngredient.create!(dish_id: @salad.id, ingredient_id: @lettuce.id)
    DishIngredient.create!(dish_id: @salad.id, ingredient_id: @dressing.id)

    visit dish_path(@sushi)
  end

  it 'I see the dish\’s name and description' do
    expect(page).to have_content(@sushi.name)
    expect(page).to have_content(@sushi.description)
    expect(page).to_not have_content(@salad.name)
  end

  it 'And I see a list of ingredients for that dish' do
    expect(page).to have_content(@rice.name)
    expect(page).to have_content(@salmon.name)
    expect(page).to_not have_content(@lettuce.name)
  end
  
  it 'and a total calorie count for that dish' do
    expect(page).to have_content('350 calories')
  end

  it 'And I see the chef\'s name.' do
    expect(page).to have_content(@gordon.name)
    expect(page).to_not have_content(@emeril.name)
  end
end