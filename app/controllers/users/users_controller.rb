class Users::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @recipe = Recipe.new
  end

  def index
    @mates = current_user.matchers
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新しました"
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
  end

  def recipes
    @user = User.find(params[:id])
    @recipes = Recipe.where(user_id: @user.id)
  end

  def followings
    user = User.find(params[:user_id])
		@users = user.followings
		render 'followings'
  end

  def followers
    user = User.find(params[:user_id])
		@users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
