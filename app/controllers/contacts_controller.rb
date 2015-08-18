class ContactsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  respond_to :html
	respond_to :json, only: [:index]

  def index
		if params[:search]
			params[:contact_name] = params[:search].sub '*', '' 
			@contacts = Contact.filter(params.slice(:contact_name)).filter(params.slice(:project_id))
		else
			@contacts = Contact.all
		end
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
			 respond_with(@contact) do |format|
				 format.ajax {render :partial => 'contacts/bad_contact', :object => @contact, :formats => [:html]}
			 end
     end
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
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
