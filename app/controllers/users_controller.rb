class UsersController < ApplicationController

  before_filter :signed_in_user, except: [:new, :create]
  before_filter :admin_or_owner_user, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    @apps = @user.apps
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    save_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def add_app
    @user = User.find(params[:id])
    @app = App.new
    @app.user = @user
    @app_types = AppType.all
    render 'apps/new'
  end

  private

    def admin_or_owner_user
      if !current_user.admin?
        @user = User.find_by_id(params[:id])
        redirect_to root_path if @user != current_user
      end
    end

    def save_user
      @user = User.new(params[:user])
      if @user.save
        if current_user and current_user.admin?
          redirect_to @user
        else
          sign_in @user
          flash[:success] = "Welcome to the App Contraption!"
          redirect_back_or(root_path)
        end
      else
        render 'new'
      end
    end
    
end
