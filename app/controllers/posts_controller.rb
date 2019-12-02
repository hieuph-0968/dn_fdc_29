class PostsController < ApplicationController
  before_action :logged_in_user, only: :create
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = "post created!"
      redirect_to topic_path(@post.topic_id)
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :topic_id)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "users.logged"
    redirect_to login_path
  end
end
