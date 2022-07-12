class Users::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @recipe = Recipe.new
  end

  def index
    @users = User.all
    @recipe = Recipe.new
  end

  def edit
  end
end
