class Admin::PostsController < ApplicationController

  def index
    @posts = Post.where(is_draft: false).page(params[:page]).per(2)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    # 前ページセッションを記録=>indexページ（全体or個人）
    session[:previous_url] = request.referer
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # showで記録したページに戻る
    redirect_to session[:previous_url]
  end

end
