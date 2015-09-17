class ProjectsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @search = Project.joins(:priority).search do 
			

      fulltext params[:search]
      
      #This splits the sort pram call. 
      view_context.set_sort_order(params[:sort], :priority_val_asc) do |call,dir| 
        order_by(call, dir)
      end 
      #order_by(:priority_val, :asc) 
      paginate(:page => params[:page] || 1, :per_page => 25)
    end
    
    @projects = @search.results #.sorted(params[:sort], 'priorities.val ASC').page(params[:page]).per 25
  end

  def show
		respond_to do |format|
			format.html
			format.js do 
				render plain: "OK"
			end
		end
  end

  def edit
		respond_to do |format|
			format.html
			format.js do
				dynamic_field_edit @project, params['field_name']
				#dynamic_text_area @project, params['field_name'], ajax: true
			end
		end
  end

  def update
		if @project.update project_params
			respond_to do |format|
				format.html do
					redirect_to @project
				end
				format.js do
					@project.format_text_fields
					@show = params[:project].keys.first.sub(/_id$/,'')
					render :show
				end
			end
		else
			respond_to do |format|
				format.html do
					render :edit
				end
				format.js do
					render :show
				end
			end
		end
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to @project
    else
      @flash = flash
      render :new
    end
  end

  def new
    @project = Project.new
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
	def test
		render plain: "New text"
	end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit :started, :customer_id, :status_id, :project_type_id, :goal, :priority_id, :title, :soft_deadline, :notes, :stumbling_blocks, :customer_notes, :results_notes,
        :project_links_attributes => [:id, :name, :url, :notes, :is_results],
        :steps_attributes => [:action, :note, :val, :step_status_id, :id, :due],
        :contacts_attributes => [:contact_name, :phone, :email, :address, :id],
        :communications_attributes => [:summary, :notes, :communication_status_id, :communication_type_id, :contact_id, :id, :comm_date]
  end
end
