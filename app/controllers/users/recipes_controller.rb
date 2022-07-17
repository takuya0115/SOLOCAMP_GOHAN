class Users::RecipesController < ApplicationController
  before_action :authenticate_user!

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
      render 'index'
    end
  end

  def index
    # byebug
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "レシピを更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:cooking_name, :material, :making, :make_time, :recipe_image)
  end
end