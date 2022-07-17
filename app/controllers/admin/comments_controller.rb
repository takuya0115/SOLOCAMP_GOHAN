class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
    #binding.pry
    if @comment.destroy
      flash.now[:notice] = "コメントを削除しました"
      #render :"users/recipes/show"
    end
  end
end
