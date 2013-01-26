class GadgetsController < ApplicationController
  # GET /gadgets
  # GET /gadgets.json
  def index
    @gadgets = Gadget.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gadgets }
    end
  end

  # GET /gadgets/1
  # GET /gadgets/1.json
  def show
    @gadget = Gadget.find(params[:id])

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
    @gadget = Gadget.new(params[:gadget])

    respond_to do |format|
      if @gadget.save
        format.html { redirect_to @gadget, notice: 'Gadget was successfully created.' }
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
        format.html { redirect_to @gadget, notice: 'Gadget was successfully updated.' }
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
      format.html { redirect_to gadgets_url }
      format.json { head :no_content }
    end
  end
end
