class UsersController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, except: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @gadgets = @user.gadgets.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    if signed_in? 
      redirect_to(root_path)
    else
      @user = User.new
    end
  end

  def create
    if signed_in? 
      redirect_to(root_path)
    else
      save_user
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
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

  def add_gadget
    @user = User.find(params[:id])
    gadget = @user.gadgets.build(params[:gadget])
    if gadget.save
      flash[:success] = "Gadget created!"
    else
      flash[:error] = gadget.errors.full_messages
    end
  end

  def remove_gadget
    @user = User.find(params[:id])
    gadget = @user.gadgets.find_by_id(params[:gadget])
    gadget.destroy
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user.admin?
    end

    def save_user
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the App Contraption!"
        redirect_to @user
      else
        render 'new'
      end
    end
    
end
