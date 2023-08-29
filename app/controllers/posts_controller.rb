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
    @current_user = current_user
    @like = Like.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    post.comments_counter = 0
    post.likes_counter = 0

    if post.save
      flash[:success] = 'post saved successfully'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash.now[:error] = 'error: question could not be saved'
    end
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
