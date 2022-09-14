class Users::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path(@recipe), notice: "レシピを投稿しました"
    else
      @recipes = Recipe.all
      #flash.now[:error] = "レシピの投稿に失敗しました"
      render 'create'
    end
  end

  def index
    # byebug
    @recipe = Recipe.new
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      render "edit"
    else
      redirect_to recipe_path
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "レシピを更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_user_path, notice: "レシピを削除しました"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:cooking_name, :material, :making, :make_time, :recipe_image)
  end
end