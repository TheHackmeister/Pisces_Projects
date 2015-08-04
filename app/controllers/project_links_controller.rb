class ProjectLinksController < ApplicationController
  load_and_authorize_resource 
  before_action :set_project_link, only: [:show, :edit, :update, :destroy]
	respond_to :html
	respond_to :ajax, only: [:create]

  def index
    @project_links = ProjectLink.all
		respond_with(@project_links)
  end

  def show
		respond_with(@project_link)
  end

  def new
    @project_link = ProjectLink.new
		respond_with(@project_link)
  end

  def edit
		respond_with(@project_link)
  end

  def create
    @project_link = ProjectLink.new(project_link_params)
		
# Fix this!
		respond_with(@project_link) do |format|
      if @project_link.save
        format.html { redirect_to @project_link, notice: 'Project link was successfully created.' }
        format.json { render :show, status: :created, location: @project_link }
        format.ajax { render :partial => 'project_links/show_single', :object => @project_link, :formats => [:html]}
      else
        format.html { render :new }
        format.json { render json: @project_link.errors, status: :unprocessable_entity }
        format.ajax { render :partial => 'project_links/bad_link', :object => @project_link, :formats => [:html]}
      end
    end
  end

  def update
    respond_with(@project_link) do |format|
      if @project_link.update(project_link_params)
        format.html { redirect_to @project_link, notice: 'Project link was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_link }
      else
        format.html { render :edit }
        format.json { render json: @project_link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_link.destroy

    respond_with(@project_link) do |format|
      format.html { redirect_to project_links_url, notice: 'Project link was successfully destroyed.' }
      format.json { head :no_content }
      format.ajax { render :partial => 'project_links/ajax_delete', :object => @project_link, :formats => [:html] }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_link
      @project_link = ProjectLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_link_params
      params.require(:project_link).permit(:project_id, :sort, :name, :url, :notes)
    end
end
