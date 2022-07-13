class Users::CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
    if @comment.save
      flash.now[:notice] = "コメントを投稿しました"
      @comment = Comment.new
      render :"users/recipes/show"
    end
  end

  def destroy
    @commnet = Comment.find(params[:id])
    @comments = @recipe.comments.order(created_at: :desc) #コメントを新着順で表示
    if @commnet.destroy
      flash.now[:notice] = "コメントを削除しました"
      render :"users/recipes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :recipe_id)
  end
end
