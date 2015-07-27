class CommunicationStatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_communication_status, only: [:show, :edit, :update, :destroy]
  respond_to :html
	respond_to :json, only: [:index]
	
	def index
    @communication_statuses = CommunicationStatus.all
    respond_with(@communication_statuses)
  end

  def show
    respond_with(@communication_status)
  end

  def new
    @communication_status = CommunicationStatus.new
    respond_with(@communication_status)
  end

  def edit
  end

  def create
    @communication_status = CommunicationStatus.new(communication_status_params)
		if not @communication_status.save
			flash[:alert] = @communication_status.errors.full_messages 
		end
    respond_with(@communication_status)
  end

  def update
    if not @communication_status.update(communication_status_params)
			flash[:alert] = @communication_status.errors.full_messages 
		end
    respond_with(@communication_status)
  end

  def destroy
    if not @communication_status.destroy
			flash[:alert] = @communication_status.errors.full_messages 
		end
    respond_with(@communication_status)
  end

  private
    def set_communication_status
      @communication_status = CommunicationStatus.find(params[:id])
    end

    def communication_status_params
      params.require(:communication_status).permit(:text, :val)
    end
end
