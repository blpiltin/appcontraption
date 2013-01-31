class AppsController < ApplicationController

  before_filter :signed_in_user
  before_filter :admin_or_owner_user, 
    except: [:index, :new, :create, :add_gadget]
  before_filter :admin_user, only: :delete

  def index
  	@apps = current_user.apps.paginate(page: params[:page])
    @all_apps = current_user.apps
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_apps }
    end
  end

  def show
  	@app = App.find(params[:id])
  	@gadgets = @app.gadgets
  end

  def new
  	@app = App.new
    @app.user = current_user
    @app_types = AppType.all
  end

  def edit
  	@app = App.find(params[:id])
    @app_types = AppType.all
  end

  def create
  	@app = App.new(params[:app], :without_protection => true)
    @app.user_id = params[:app][:user_id]
    @app.app_type_id = params[:app][:app_type_id]
    @app_types = AppType.all
    if @app.save
    	redirect_to @app, notice: 'App was successfully created.'
    else
    	render action: "new"
    end
  end

  def update
  	@app = App.find(params[:id])
		if @app.update_attributes(params[:app])
      redirect_to @app, notice: 'App was successfully updated.'
    else
    	render action: "edit" 
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to @app.user, notice: 'App was successfully deleted.'
  end

  def add_gadget
    @app = App.find(params[:id])
    @gadget = Gadget.new
    @gadget.app = @app
    @gadget_types = GadgetType.all
    render 'gadgets/new'
  end

  private

    def admin_or_owner_user
    	if !current_user.admin?
      	@app = current_user.apps.find_by_id(params[:id])
      	redirect_to root_path if @app.nil? and !current_user.admin?
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
