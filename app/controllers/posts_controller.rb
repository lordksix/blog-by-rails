class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
