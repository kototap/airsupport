class Public::PostsController < ApplicationController

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def search
    @search = Post.ransack(params[:q])
    # OR検索
    @search.combinator = 'or'
  end

  def search_index
    @search = Post.ransack(params[:q])
    @posts = @search.result(distinct: true)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :airport, :post_image, :tag_id)
  end


end
