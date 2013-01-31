class MenuCategoriesController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show]
  before_filter :admin_or_owner_user, except: [:index, :new, :create]
  before_filter :admin_user, only: :delete

  def show
    @menu_category = MenuCategory.find(params[:id])
    @menu_items = []
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_category }
    end
  end

  def new
    @menu_category = MenuCategory.new
  end

  def edit
    @menu_category = MenuCategory.find(params[:id])
  end

  def create
    @menu_category = 
      MenuCategory.new(params[:menu_category], :without_protection => true)
    @menu_category.gadget_id = params[:menu_category][:gadget_id]
    @menu_category.position = 
      MenuCategory.find_all_by_gadget_id(params[:menu_category][:gadget_id]).count + 1
    if @menu_category.save
      redirect_to @menu_category.gadget, notice: 'Menu category was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @menu_category = MenuCategory.find(params[:id])
    if @menu_category.update_attributes(params[:menu_category])
      redirect_to menu_category_path(@menu_category), notice: 'Menu category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @menu_category = MenuCategory.find(params[:id])
    @menu_category.destroy
    redirect_to @menu_category.gadget, notice: 'Menu category was successfully deleted.'
  end

  private

    def admin_or_owner_user
      if !current_user.admin?
        @menu_category = MenuCategory.find_by_id(params[:id])
        @user = @menu_category.gadget.app.user
        redirect_to root_path if @user != current_user
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
