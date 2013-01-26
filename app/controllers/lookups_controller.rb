class LookupsController < ApplicationController
  before_filter :signed_in_user, :admin_user

  # GET /lookups
  # GET /lookups.json
  def index
    @lookups = Lookup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lookups }
    end
  end

  # GET /lookups/1
  # GET /lookups/1.json
  def show
    @lookup = Lookup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lookup }
    end
  end

  # GET /lookups/new
  # GET /lookups/new.json
  def new
    @lookup = Lookup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lookup }
    end
  end

  # GET /lookups/1/edit
  def edit
    @lookup = Lookup.find(params[:id])
  end

  # POST /lookups
  # POST /lookups.json
  def create
    @lookup = Lookup.new(params[:lookup])

    respond_to do |format|
      if @lookup.save
        format.html { redirect_to @lookup, notice: 'Lookup was successfully created.' }
        format.json { render json: @lookup, status: :created, location: @lookup }
      else
        format.html { render action: "new" }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lookups/1
  # PUT /lookups/1.json
  def update
    @lookup = Lookup.find(params[:id])

    respond_to do |format|
      if @lookup.update_attributes(params[:lookup])
        format.html { redirect_to @lookup, notice: 'Lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
