class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
  end

  def edit
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to admin_recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:cooking_name, :material, :making, :make_time, :recipe_image)
  end

end
