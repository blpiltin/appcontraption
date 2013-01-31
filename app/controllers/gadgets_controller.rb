class GadgetsController < ApplicationController

  before_filter :signed_in_user
  before_filter :admin_or_owner_user, 
    except: [:index, :new, :create]
  before_filter :admin_user, only: :delete

  # GET /gadgets
  # GET /gadgets.json
  def index
    @user = current_user
    @gadgets = @user.gadgets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gadgets }
    end
  end

  # GET /gadgets/1
  # GET /gadgets/1.json
  def show
    @gadget = Gadget.find(params[:id])
    @menu_categories = []
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gadget }
    end
  end

  # GET /gadgets/new
  # GET /gadgets/new.json
  def new
    @gadget = Gadget.new
    @gadget_types = GadgetType.all
  end

  # GET /gadgets/1/edit
  def edit
    @gadget = Gadget.find(params[:id])
  end

  # POST /gadgets
  # POST /gadgets.json
  def create
    @gadget = Gadget.new
    @gadget.app_id = params[:gadget][:app_id]
    @gadget.gadget_type_id = params[:gadget][:gadget_type_id]
    @gadget.position = 
      Gadget.find_all_by_app_id(params[:gadget][:app_id]).count + 1
    @gadget_types = GadgetType.all
    if @gadget.save
      redirect_to @gadget.app, notice: 'Gadget was successfully created.'
    else
      render action: "new" 
    end
  end

  # PUT /gadgets/1
  # PUT /gadgets/1.json
  def update
    @gadget = Gadget.find(params[:id])

    if @gadget.update_attributes(params[:gadget])
      redirect_to gadget_path(@gadget), notice: 'Gadget was successfully updated.'
    else
      render action: "edit"
    end

  end

  # DELETE /gadgets/1
  # DELETE /gadgets/1.json
  def destroy
    @gadget = Gadget.find(params[:id])
    @gadget.destroy
    redirect_to @gadget.app, notice: 'Gadget was successfully deleted.'
  end

  private

    def admin_or_owner_user
      if !current_user.admin?
        @gadget = Gadget.find_by_id(params[:id])
        @user = @gadget.app.user
        redirect_to root_path if @user != current_user
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
