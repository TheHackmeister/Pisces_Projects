class ProjectTypesController < ApplicationController
  before_action :set_project_type, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @project_types = ProjectType.all
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
    @project_type.update(project_type_params)
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
