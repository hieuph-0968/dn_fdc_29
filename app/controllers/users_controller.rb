class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, only: [:show, :edit, :update]

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t ".profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".sucess"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "users.logged"
    redirect_to login_path
  end

  def load_user
    @user = User.find(params[:id])
  end
end
