class CommunicationTypesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_communication_type, only: [:show, :edit, :update, :destroy]
  respond_to :html
	respond_to :json, only: [:index]

	def index
    @communication_types = CommunicationType.all
    respond_with(@communication_types)
  end

  def show
    respond_with(@communication_type)
  end

  def new
    @communication_type = CommunicationType.new
    respond_with(@communication_type)
  end

  def edit
  end

  def create
    @communication_type = CommunicationType.new(communication_type_params)
		if not @communication_type.save
			flash[:alert] = @communication_type.errors.full_messages 
		end
    respond_with(@communication_type)
  end

  def update
		if not @communication_type.update(communication_type_params)
			flash[:alert] = @communication_type.errors.full_messages 
		end
    respond_with(@communication_type)
  end

  def destroy
		if not @communication_type.destroy
			flash[:alert] = @communication_type.errors.full_messages 
		end
    respond_with(@communication_type)
  end

  private
    def set_communication_type
      @communication_type = CommunicationType.find(params[:id])
    end

    def communication_type_params
      params.require(:communication_type).permit(:text, :val)
    end
end
