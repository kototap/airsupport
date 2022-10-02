class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :search_index]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 投稿ボタンを押下した場合
    if params[:send]
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "投稿しました。"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    # 下書きボタンを押下した場合
    else
      if @post.update(is_draft: true)
        redirect_to user_path(current_user), notice: "下書きを保存しました。"
      else
        render :new, alert: "保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください。"
      end
    end
  end


  # 公開されている投稿のみ表示
  def index
    # 人気記事順
    if params[:popular]
      posts = Post.release.sort { |a, b| b.bookmarks.count <=> a.bookmarks.count }
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    # 新着順
    elsif params[:latest]
      posts = Post.release.latest
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    # 検索時
    else
      @search = Post.left_joins(:tags).release.ransack(params[:q])
      posts = @search.result(distinct: true)
      # 投稿のタグを押した時
      posts =
        if params[:tag_ids]
          posts.where(tags: {id: params[:tag_ids]})
        elsif params[:airport]
          posts.where(airport: params[:airport])
        else
          posts
        end
      @posts = posts.latest.page(params[:page])
    end
  end


  # 下書きの投稿のみ表示
  def draft_index
    @posts = current_user.posts.draft.latest.page(params[:page])
  end


  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(5)

    # 他のユーザーは下書き投稿にアクセスできないようにする
    if (@post.is_draft == true) && @post.user != current_user
      redirect_to root_path
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    @user = current_user
    redirect_to user_path(@user)
  end


  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end


  def update
    @post = Post.find(params[:id])
    # 下書きを公開するする場合
    if params[:publicize_draft]
      @post.attributes = post_params.merge(is_draft: false)
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "下書きの投稿を公開しました！"
      else
        @post.is_draft = true
        render :edit, alert: "投稿を公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 公開済み投稿の更新の場合
    elsif params[:update_post]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "投稿を更新しました！"
      else
        render :edit, alert: "投稿を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きを非公開のまま更新する場合
    else
      if @post.update(post_params)
        redirect_to post_path(@post), notice: "下書きを更新しました！"
      else
        render :edit, alert: "下書きを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end



  private
    def post_params
      params.require(:post).permit(:title, :body, :airport, :post_image, :is_draft, :address, tag_ids: [])
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      @user = @post.user
      unless @user == current_user
        redirect_to posts_path, notice: "他のユーザーの投稿編集画面へは遷移できません。"
      end
    end
end
