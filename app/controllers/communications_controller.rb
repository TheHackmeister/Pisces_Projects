class CommunicationsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_communication, only: [:show, :edit, :update, :destroy]
  respond_to :html
	respond_to :json, :ajax, only: [:create]

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
		
		# If there isn't a contact, but we have an email, try to use or create that contact anyway. 
		if(communication_params.fetch(:contact_id, nil) == nil and other_params.fetch(:contact_email, nil) != nil) 
			@communication.create_contact(other_params.fetch(:contact_email), other_params.fetch(:contact_name, nil))
		end

# I don't know if messing with format is necessary.  
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
    if not @communication.update(communication_params)
			flash[:alert] = @communication.errors.full_messages 
		end
    respond_with(@communication)
  end

  def destroy
		if not @communication.destroy
			flash[:alert] = @communication.errors.full_messages 
		end
    respond_with(@communication)
  end

  private
    def set_communication
      @communication = Communication.find(params[:id])
    end

    def communication_params
      params.require(:communication).permit(:summary, :notes, :communication_status_id, :communication_type_id, :project_id, :contact_id, :comm_date)
    end

		def other_params
			params.permit(:contact_email, :contact_name)
		end
end
