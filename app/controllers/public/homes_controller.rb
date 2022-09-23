class Public::HomesController < ApplicationController
  def top
    @posts = Post.release.latest.limit(3)
    @ranks = Post.release.find(Bookmark.group(:post_id).where(created_at: Time.current.all_week).order("count(post_id) desc").limit(3).pluck(:post_id))
  end

  def about
  end
end
