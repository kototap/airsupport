class Public::HomesController < ApplicationController
  def top
    @posts = Post.where(is_draft: false).order(created_at: :desc).limit(3)
    @ranks = Post.where(is_draft: false).find(Bookmark.group(:post_id).where(created_at: Time.current.all_month).order("count(post_id) desc").limit(3).pluck(:post_id))
    # @ranks = Post.where(is_draft: false).sort{ |a, b| b.bookmarks.where(created_at: Time.current.all_week).count <=> a.bookmarks.where(created_at: Time.current.all_week).count}
  end

  def about
  end
end
