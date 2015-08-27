
class CdbBatchProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_cdb_batch_project, only: [:show, :edit, :update, :destroy]
  respond_to :html, :ajax, :json, :js


  def index
    @cdb_batch_projects = CdbBatchProject.all
    respond_with(@cdb_batch_projects)
  end


  def show
    respond_with(@cdb_batch_project)
  end

  def new
    @cdb_batch_project = CdbBatchProject.new
    respond_with(@cdb_batch_project)
  end

  def edit
    respond_with(@cdb_batch_project)
  end

  def create
    @cdb_batch_project = view_context.new_cd_batch_projects cdb_batch_project_params
    respond_with(@cdb_batch_project) do |format|
			format.ajax { render partial: 'multiple', object: @cdb_batch_project, formats: [:html]}
		end
  end

  def update
    @cdb_batch_project.update(cdb_batch_project_params)
    respond_with(@cdb_batch_project)
  end

  def destroy
    @cdb_batch_project.destroy
    respond_with(@cdb_batch_project) do |format|
			format.ajax { render partial: 'cdb_batch_projects/ajax_delete', object: @cdb_batch_project, formats: [:html] }
		end
  end

  private
    def set_cdb_batch_project
      @cdb_batch_project = CdbBatchProject.find(params[:id])
    end

    def cdb_batch_project_params

      params.require(:cdb_batch_project).permit(:cdb_batch_id, :project_id, :cd_batch_id)

    end
end

