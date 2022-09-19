class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(5)
    if @post_comment.save
      render :comments
    else
      render :comments
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(5)
    render :comments
  end


  private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
