class MenuItemsController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show]
  before_filter :admin_or_owner_user, except: [:index, :new, :create]

  def show
    @menu_item = MenuItem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_item }
    end
  end

  def new
    @menu_item = MenuItem.new
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def create
    @menu_item = 
      MenuItem.new(params[:menu_item], :without_protection => true)
    @menu_item.menu_category_id = params[:menu_item][:menu_category_id]
    @menu_item.position = 
      MenuItem.find_all_by_menu_category_id(params[:menu_item][:menu_category_id]).count + 1
    if @menu_item.save
      redirect_to @menu_item.menu_category, notice: 'Menu item was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.update_attributes(params[:menu_item])
      redirect_to @menu_item.menu_category, notice: 'Menu item was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    redirect_to @menu_item.menu_category, notice: 'Menu item was successfully deleted.'
  end

  private

    def admin_or_owner_user
      if !current_user.admin?
        @menu_item = MenuItem.find_by_id(params[:id])
        @user = @menu_item.menu_category.gadget.app.user
        redirect_to root_path if @user != current_user
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
