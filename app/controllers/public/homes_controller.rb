class Public::HomesController < ApplicationController
  def top
    @posts = Post.where(is_draft: false).order(created_at: :desc).limit(3)
  end

  def about
  end
end
