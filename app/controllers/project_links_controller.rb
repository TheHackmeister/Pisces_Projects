class ProjectLinksController < ApplicationController
  before_action :set_project_link, only: [:show, :edit, :update, :destroy]

  # GET /project_links
  # GET /project_links.json
  def index
    @project_links = ProjectLink.all
  end

  # GET /project_links/1
  # GET /project_links/1.json
  def show
  end

  # GET /project_links/new
  def new
    @project_link = ProjectLink.new
  end

  # GET /project_links/1/edit
  def edit
  end

  # POST /project_links
  # POST /project_links.json
  def create
    @project_link = ProjectLink.new(project_link_params)

    respond_to do |format|
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

  # PATCH/PUT /project_links/1
  # PATCH/PUT /project_links/1.json
  def update
    respond_to do |format|
      if @project_link.update(project_link_params)
        format.html { redirect_to @project_link, notice: 'Project link was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_link }
      else
        format.html { render :edit }
        format.json { render json: @project_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_links/1
  # DELETE /project_links/1.json
  def destroy
    @project_link.destroy
    respond_to do |format|
      format.html { redirect_to project_links_url, notice: 'Project link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_link
      @project_link = ProjectLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_link_params
      params.require(:project_link).permit(:Project_id, :sort, :name, :url, :notes)
    end
end
