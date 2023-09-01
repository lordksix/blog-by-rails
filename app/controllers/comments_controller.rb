class CommentsController < ApplicationController
  authorize_resource
  before_action :find_user_post_by_id

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.post = @post
    comment.author = current_user
    if comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:post_id]}"
    else
      flash.now[:error] = 'Error: comment could not be saved'
      redirect_to new_comment
    end
  end

  def destroy
    @post.comments.destroy(params[:id])
    redirect_to "/users/#{params[:user_id]}/posts/#{params[:post_id]}"
  end

  private

  def find_user_post_by_id
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
