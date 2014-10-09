class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]
    if @project.update project_params
      redirect_to @project
    else
      render :edit
    end
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def new
    @project = Project.new
  end

  private

  def project_params
    params.require(:project).permit :started, :customer_id, :status_id, :goal, :priority_id, :title, :soft_deadline, :notes, :stumbling_blocks, :customer_notes,
        :project_links_attributes => [:id, :name, :url, :notes],
        :steps_attributes => [:action, :note, :val, :step_status_id, :id]
  end
end
