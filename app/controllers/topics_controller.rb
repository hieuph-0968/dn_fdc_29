class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 4)
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order(created_at: :desc).paginate page: params[:page], per_page: 6
  end
end
