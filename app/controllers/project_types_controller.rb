class ProjectTypesController < ApplicationController
	load_and_authorize_resource
  
	before_action :set_project_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :edit
  end

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
    @project_type.save
    respond_with(@project_type)
  end

  def update
		flash[:alert] = @project_type.errors.full_messages unless @project_type.update(project_type_params)
    respond_with(@project_type)
  end

  def destroy
    @project_type.destroy
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
