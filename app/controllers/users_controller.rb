class UsersController < ApplicationController

  before_filter :signed_in_user
  before_filter :admin_user, except: [:edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @gadgets = @user.gadgets
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
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def add_gadget
    @user = User.find(params[:id])
    @gadget = Gadget.new
    @gadget.user = @user
    @gadget_types = GadgetType.all
    render 'gadgets/new'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def save_user
      @user = User.new(params[:user])
      if @user.save
        if current_user.admin?
          redirect_to @user
        else
          sign_in @user
          flash[:success] = "Welcome to the App Contraption!"
          redirect_to @user
        end
      else
        render 'new'
      end
    end
    
end
