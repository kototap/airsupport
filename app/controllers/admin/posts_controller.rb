class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.where(is_draft: false).order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(5)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
