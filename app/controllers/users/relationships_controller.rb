class Users::RelationshipsController < ApplicationController
  def create
    Relationship.create(follower_id: current_user.id, followed_id: params[:user_id])
    redirect_to user_path(params[:user_id]), notice: "友達になりました!"
  end

  def destroy
    other_user = User.find(params[:user_id])
    current_user.unfollow(other_user)
    redirect_to user_path(params[:user_id]), notice: "友達を解除しました！"
  end

  def followings
    @user = User.find(params[:user_id])
		@users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
		@users = @user.followers
  end
end
