class ContactsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  respond_to :html
	respond_to :json, only: [:index]

  def index
    @contacts = Contact.filter(params.slice(:contact_name)).filter(params.slice(:project_id))
    respond_with(@contacts)
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
# Is there a better way of doing this? See communications for another example.
    @contact = Contact.new(contact_params)
     if @contact.save 
        respond_with(@contact) do |format|
          format.ajax {render :partial => 'contacts/show_single', :object => @contact, :formats => [:html]}
        end
     else
			 flash[:alert] = @contact.errors.full_messages 
			 respond_with(@contact) do |format|
				 format.ajax {render :partial => 'contacts/bad_contact', :object => @contact, :formats => [:html]}
			 end
     end
  end

  def update
    if not @contact.update(contact_params)
			flash[:alert] = @contact.errors.full_messages 
		end
    respond_with(@contact)
  end

  def destroy
    if not @contact.destroy
			flash[:alert] = @contact.errors.full_messages 
		end
		respond_with(@contact)
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:contact_name, :phone, :email, :address, :project_id, :id)
    end
end
