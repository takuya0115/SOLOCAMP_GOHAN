class Users::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path(@recipe), notice: "You have created book successfully."
    else
      @recipes = Recipe.all
      render 'index'
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:cooking_name, :material, :making, :make_time, :recipe_image)
  end

end

