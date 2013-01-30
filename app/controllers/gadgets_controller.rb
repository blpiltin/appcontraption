class GadgetsController < ApplicationController

  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :destroy]
  before_filter :correct_user, only: [:show, :edit, :update]

  # GET /gadgets
  # GET /gadgets.json
  def gadgets
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gadget }
    end
  end

  # GET /gadgets/1/edit
  def edit
    @gadget = Gadget.find(params[:id])
  end

  # POST /gadgets
  # POST /gadgets.json
  def create
    @gadget = Gadget.new
    @gadget.user_id = params[:gadget][:user_id]
    @gadget.gadget_type_id = params[:gadget][:gadget_type_id]
    @gadget.position = Gadget.find_all_by_user_id(params[:gadget][:user_id]).count
    @gadget_types = GadgetType.all
    respond_to do |format|
      if @gadget.save
        format.html { redirect_to @gadget.user, notice: 'Gadget was successfully created.' }
        format.json { render json: @gadget, status: :created, location: @gadget }
      else
        format.html { render action: "new" }
        format.json { render json: @gadget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gadgets/1
  # PUT /gadgets/1.json
  def update
    @gadget = Gadget.find(params[:id])

    respond_to do |format|
      if @gadget.update_attributes(params[:gadget])
        if current_user.admin?
          format.html { redirect_to @gadget.user, notice: 'Gadget was successfully updated.' }
        else
          format.html { redirect_to @gadget, notice: 'Gadget was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gadget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gadgets/1
  # DELETE /gadgets/1.json
  def destroy
    @gadget = Gadget.find(params[:id])
    @gadget.destroy

    respond_to do |format|
      format.html { redirect_to @gadget.user, notice: 'Gadget was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def correct_user
      @gadget = current_user.gadgets.find_by_id(params[:id])
      redirect_to root_url if @gadget.nil? and !current_user.admin?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
