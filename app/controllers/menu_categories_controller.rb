class MenuCategoriesController < ApplicationController

  before_filter :signed_in_user, 
    except: [:index_json, :show_json]
  before_filter :admin_or_owner_user, 
    except: [:index_json, :show_json, :new, :create, :index, :sort]
  before_filter :api_user, 
    only: [:index_json, :show_json]

  def index_json
    @menu_categories = 
      MenuCategory.find_all_by_app_id(params[:app_id])
    respond_to do |format|
      format.json { render json: @menu_categories }
    end
  end

  def show_json
    @menu_items = 
      MenuItem.where(menu_category_id:params[:id])
    respond_to do |format|
      format.json { render json: @menu_items }
    end
  end

  # def index
  #   # @menu_categories = MenuCategory.find_all_by_gadget_id(params[:id])
  #   @menu_categories.order('menu_categories.position ASC')
  # end

  def sort
    @menu_categories = 
      MenuCategory.find_all_by_gadget_id(params[:id])
    @menu_categories.each do |menu_category|
      menu_category.position = 
        params['menu_category'].index(menu_category.id.to_s) + 1
      menu_category.save
    end
    render nothing: true
  end

  def show
    @menu_category = MenuCategory.find(params[:id])
    @menu_items = @menu_category.menu_items
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

  def add_menu_item
    @menu_category = MenuCategory.find(params[:id])
    @menu_item = MenuItem.new
    @menu_item.menu_category = @menu_category
    render 'menu_items/new'
  end

  private

    def admin_or_owner_user
      if !current_user.admin?
        @menu_category = MenuCategory.find_by_id(params[:id])
        @user = @menu_category.gadget.app.user
        redirect_to root_path if @user != current_user
      end
    end

    def admin_or_gadget_owner_user
      if !current_user.admin?
        @gadget = Gadget.find_by_id(params[:id])
        @user = @gadget.app.user
        redirect_to root_path if @user != current_user
      end
    end

    def api_user
      @app = App.find(params[:app_id])
      head :unauthorized unless @app.access_token == params[:access_token]
    end

end
