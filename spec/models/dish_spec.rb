require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through :dish_ingredients}
  end

  describe 'instance methods' do
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
    end

    describe '#sum_calories' do
      it 'returns the total sum of calories in a dish' do
        expect(@sushi.sum_calories).to eq(350)
        expect(@salad.sum_calories).to eq(280)
      end
    end
  end
end