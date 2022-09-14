class ApplicationController < ActionController::Base
before_action :set_search

def set_search
  @search = Post.ransack(params[:q])
  @posts = @search.result.order(created_at: :desc).page(params[:page])
end
end
