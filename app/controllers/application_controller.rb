class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Post.left_joins(:tags).release.ransack(params[:q])
    posts = @search.result(distinct: true)
    @posts = posts.latest.page(params[:page])
  end
end
