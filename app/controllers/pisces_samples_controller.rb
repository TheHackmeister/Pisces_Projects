
class PiscesSamplesController < ApplicationController
  load_and_authorize_resource
  before_action :set_pisces_sample, only: [:show, :edit, :update, :destroy]
  respond_to :html


  def index
		@search = PiscesSample.search do
			fulltext params[:search]
			order_by :sample_id, :desc
			paginate page: params[:page] || 1, per_page: 25
		end
		@pisces_samples = @search.results
    respond_with(@pisces_samples)
  end


  def show
    respond_with(@pisces_sample)
	end
=begin
  def new
    @pisces_sample = PiscesSample.new
    respond_with(@pisces_sample)
  end

  def edit
    respond_with(@pisces_sample)
  end

  def create
    @pisces_sample = PiscesSample.new(pisces_sample_params)
    @pisces_sample.save
    respond_with(@pisces_sample)
  end

  def update
    @pisces_sample.update(pisces_sample_params)
    respond_with(@pisces_sample)
  end

  def destroy
    @pisces_sample.destroy
    respond_with(@pisces_sample)
  end
=end
  private
    def set_pisces_sample
      @pisces_sample = PiscesSample.find(params[:id])
    end

    def pisces_sample_params

      params.require(:pisces_sample).permit(:sample_id, :customer_id, :cd_batch_id, :source_information, :form_code, :cond_code, :logged_by, :lysis_buf_vol, :GRed, :public_comments, :pcr_comments, :gel_comments, :private_comments)

    end
end

