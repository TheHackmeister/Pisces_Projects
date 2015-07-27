class RolesController < ApplicationController
  load_and_authorize_resource 
  respond_to :html
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @roles = Role.all
    respond_with(@roles)
  end

  def show
    respond_with(@role)
  end

  def new
    @role = Role.new
    respond_with(@role)
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
		if not @role.save
			flash[:alert] = @role.errors.full_messages 
		end
    respond_with(@role)
  end

  def update
    if not @role.update(role_params)
			flash[:alert] = @role.errors.full_messages 
		end
    respond_with(@role)
  end

  def destroy
    if not @role.destroy
			flash[:alert] = @role.errors.full_messages 
		end
    respond_with(@role)
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit :title, :id, :val
    end
end
