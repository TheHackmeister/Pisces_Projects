class ProjectTypesController < ApplicationController
	load_and_authorize_resource
	before_action :set_project_type, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    search = ProjectType.search do
			order_by(:sort, :asc)
			paginate(:page => params[:page] || 1, :per_page => 5)
		end

		@project_types = search.results
    respond_with(@project_types)
  end

  def show
    respond_with(@project_type)
  end

  def new
    @project_type = ProjectType.new
    respond_with(@project_type)
  end

  def edit
  end

  def create
    @project_type = ProjectType.new(project_type_params)
		if not @project_type.save
			flash[:alert] = @project_type.errors.full_messages 
		end
    respond_with(@project_type)
  end

  def update
		if not @project_type.update(project_type_params)
			flash[:alert] = @project_type.errors.full_messages 
		end
    respond_with(@project_type)
  end

  def destroy
    if not @project_type.destroy
			flash[:alert] = @project_type.errors.full_messages 
		end
    respond_with(@project_type)
  end

  private
    def set_project_type
      @project_type = ProjectType.find(params[:id])
    end

    def project_type_params
      params.require(:project_type).permit(:text, :val, :sort)
    end
end
