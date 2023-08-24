class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    page = params[:page] || 1
    per_page = 4
    @posts = @user.posts.order(created_at: :asc).offset((page.to_i - 1) * per_page).limit(per_page)
    @total_posts = @user.posts
    @total_pages = (@total_posts.count.to_f / per_page).ceil
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
