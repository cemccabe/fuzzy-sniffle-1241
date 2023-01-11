class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])
    @dish = Dish.find(params[:dish_id])

    @chef.dishes << @dish
    redirect_to chef_path(@chef)
  end
end
