class SamplesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_sample, only: [:show, :edit, :update, :destroy]

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :edit
  end
  
  def index
		@samples = Sample.all
  end

  def show
  end

  def edit
  end

  def update
    if @sample.update sample_params
      redirect_to @sample
    else
      flash[:alert] = @sample.errors.full_messages 
      render :edit
    end
  end

  def create
    @sample = Sample.new sample_params
    if @sample.save
      redirect_to @sample
    else
      @flash = flash
      render :new
    end
  end

  def new
    @sample = Sample.new
  end

  def destroy
    @sample.destroy
    respond_to do |format|
      format.html { redirect_to samples_url, notice: 'Sample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit :customer_id, :pisces_id
  end
end
