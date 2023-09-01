class Api::V1::PostsController < Api::ApiController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render json: @posts
  end
end
