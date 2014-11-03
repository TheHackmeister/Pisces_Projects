class CommunicationsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_communication, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json, :ajax
  
  def index
    @communications = Communication.all
    respond_with(@communications)
  end

  def show
    respond_with(@communication)
  end

  def new
    @communication = Communication.new
    respond_with(@communication)
  end

  def edit
  end

  def create
    @communication = Communication.new(communication_params)
    if @communication.save
      respond_with(@communication) do |format|
        format.ajax {render :partial => 'communications/show_single', :object => @communication, :formats => [:html]}
      end
    else 
      respond_with(@communication) do |format|
        format.ajax {render :partial => 'communications/bad_communication', :object => @communication, :formats => [:html]}
      end
    end 
  end

  def update
    @communication.update(communication_params)
    respond_with(@communication)
  end

  def destroy
    @communication.destroy
    respond_with(@communication)
  end

  private
    def set_communication
      @communication = Communication.find(params[:id])
    end

    def communication_params
      params.require(:communication).permit(:summary, :notes, :communication_status_id, :communication_type_id, :project_id, :contact_id)
    end
end
