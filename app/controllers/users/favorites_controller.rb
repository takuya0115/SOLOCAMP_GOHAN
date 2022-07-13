class Users::FavoritesController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = Favorite.create(user_id: current_user.id, recipe_id: params[:recipe_id])
    @favorite.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = Favorite.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    @favorite.destroy
  end
end
