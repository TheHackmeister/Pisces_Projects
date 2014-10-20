class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  respond_to :html, :ajax, :js, :json
  def index
    @contacts = Contact.filter(params.slice(:contact_name))
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
