
class CdbBatchesController < ApplicationController
  load_and_authorize_resource
  before_action :set_cdb_batch, only: [:show, :edit, :update, :destroy]
  respond_to :html


  def index
		@search = CdbBatch.search do
			fulltext params[:search]
			order_by :cd_batch_id, :desc
			paginate page: params[:page] || 1, per_page: 25
		end

    @cdb_batches = @search.results
    respond_with(@cdb_batches)
  end


  def show
    respond_with(@cdb_batch)
  end
=begin
  def new
    @cdb_batch = CdbBatch.new
    respond_with(@cdb_batch)
  end

  def edit
    respond_with(@cdb_batch)
  end

  def create
    @cdb_batch = CdbBatch.new(cdb_batch_params)
    @cdb_batch.save
    respond_with(@cdb_batch)
  end

  def update
    @cdb_batch.update(cdb_batch_params)
    respond_with(@cdb_batch)
  end

  def destroy
    @cdb_batch.destroy
    respond_with(@cdb_batch)
  end
=end
  private
    def set_cdb_batch
      @cdb_batch = CdbBatch.find(params[:id])
    end

    def cdb_batch_params

      params.require(:cdb_batch).permit(:cd_batch_id, :received_date, :reported_date, :invoiced_date, :invoice_number, :open_by, :customer_id, :priority_code, :deadline_date, :sample_count, :any_to_be_pooled, :leads_or_contam, :spec_cust_instructions, :spec_piscesinstructions, :observations_problems, :batch_status, :geo_location, :geo_location_2, :hyperlink_report, :hyperlink_spreadsheet, :remove_by)

    end
end

