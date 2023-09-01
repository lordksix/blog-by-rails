class Api::V1::PostsController < Api::ApiController
    # GET api/v1/users/:user_id/posts
    def index
      @user = User.find(params[:user_id])
      @posts = @user.posts
      render json: @posts
    end
  end