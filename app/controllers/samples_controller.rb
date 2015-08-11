class SamplesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_sample, only: [:show, :edit, :update, :destroy]
	respond_to :html

  def index
		@samples = Sample.all
		respond_with(@samples)
  end

  def show
		respond_with(@sample)
  end

  def edit
		respond_with(@sample)
  end

  def update
    @sample.update sample_params
		respond_with(@sample)
  end

  def create
    @sample = Sample.new sample_params
    @sample.save
		respond_with(@sample)
  end

  def new
    @sample = Sample.new
		respond_with(@sample)
  end

  def destroy
    @sample.destroy
		respond_with(@sample)
  end


  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit :customer_id, :pisces_number
  end
end
