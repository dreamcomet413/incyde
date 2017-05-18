class BusinessIncubatorsController < ApplicationController

  load_and_authorize_resource

  before_action :set_business_incubator, only: [:show]
  #before_action :set_business_incubator, only: [:show, :edit, :update, :destroy]

  # GET /business_incubators
  # GET /business_incubators.json
  def index
    #raise ActiveRecord::RecordNotFound if params[:search].blank?
    #raise ActionController::RoutingError.new('Not Found') if params[:search].blank?
    if params[:search].blank? || params[:search][:province].blank?
      @business_incubators = BusinessIncubator.index_view.ordered
    else
      @business_incubators = Province.find(params[:search][:province]).business_incubators.index_view.ordered
    end
  end

  # GET /business_incubators/1
  # GET /business_incubators/1.json
  def show
  end

  ## GET /business_incubators/new
  #def new
  #  @business_incubator = BusinessIncubator.new
  #end
  #
  ## GET /business_incubators/1/edit
  #def edit
  #end
  #
  ## POST /business_incubators
  ## POST /business_incubators.json
  #def create
  #  @business_incubator = BusinessIncubator.new(business_incubator_params)
  #
  #  respond_to do |format|
  #    if @business_incubator.save
  #      format.html { redirect_to @business_incubator, notice: 'Business incubator was successfully created.' }
  #      format.json { render :show, status: :created, location: @business_incubator }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @business_incubator.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PATCH/PUT /business_incubators/1
  ## PATCH/PUT /business_incubators/1.json
  #def update
  #  respond_to do |format|
  #    if @business_incubator.update(business_incubator_params)
  #      format.html { redirect_to @business_incubator, notice: 'Business incubator was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @business_incubator }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @business_incubator.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /business_incubators/1
  ## DELETE /business_incubators/1.json
  #def destroy
  #  @business_incubator.destroy
  #  respond_to do |format|
  #    format.html { redirect_to business_incubators_url, notice: 'Business incubator was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_incubator
      @business_incubator = BusinessIncubator.find(params[:id])
    end

    ## Never trust parameters from the scary internet, only allow the white list through.
    #def business_incubator_params
    #  params.require(:business_incubator).permit(:avatar, :name, :country, :province, :city, :address, :phone, :web)
    #end
end
