class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def index
    # pageはページネーション導入後に実装する必要アリ
    @users = User.all #.page(params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to admin_user_path
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

    private
    def user_params
        params.require(:user).permit(:email, :password, :name, :is_deleted)
    end
end
