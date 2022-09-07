class Admin::UsersController < ApplicationController

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def user_index
    @user = User.find(params[:id])
    @user_posts = @user.posts.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
  
  def unsubscribe
    @user = User.find(params:id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email)
  end

end
