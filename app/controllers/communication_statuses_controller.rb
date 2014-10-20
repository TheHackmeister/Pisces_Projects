class CommunicationStatusesController < ApplicationController
  before_action :set_communication_status, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json, :ajax

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
    @communication_status.save
    respond_with(@communication_status)
  end

  def update
    @communication_status.update(communication_status_params)
    respond_with(@communication_status)
  end

  def destroy
    @communication_status.destroy
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
