class Users::FavoritesController < ApplicationController
  before_action :recipe_params, only: [:create, :destroy]

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

  private
  def recipe_params
    @recipe = Recipe.find(params[:recipe_id])
  end
end
