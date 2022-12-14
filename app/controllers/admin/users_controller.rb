class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!


  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def posts
    @user = User.find(params[:id])
    @user_posts = @user.posts.where(is_draft: false).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to admin_user_path(@user), notice: "ゲストユーザーは編集できません"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to admin_user_path(@user), notice: "ゲストユーザーは削除できません"
    else
      @user.destroy
      redirect_to admin_users_path
    end
  end

  def unsubscribe
    @user = User.find(params: id)
  end


  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image, :email, :is_deleted)
    end
end
