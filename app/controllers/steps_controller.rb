class StepsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_step, only: [:show, :edit, :update, :destroy]
	respond_to :html
	respond_to :json, only: [:create]

  def index
    @steps = Step.all
		respond_with(@steps)
  end

  def show
		respond_with(@step)
  end

  def new
    @step = Step.new
		respond_with(@step)
  end

  def edit
		respond_with(@step)
  end

  def create
    @step = Step.new(step_params)

		respond_with(@step) do |format|
      if @step.save
        format.html { redirect_to @step, notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
        format.ajax {render :partial => 'show_single', :object => @step, :formats => [:html]}
      else
				flash[:alert] = @step.errors.full_messages 
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
        format.ajax {render :partial => 'bad_step', :object => @step, :formats => [:html]}
      end
    end
  end

  def update
		if not @step.update(step_params)
			flash[:alert] = @step.errors.full_messages 
		end
		respond_with(@step)
  end

  def destroy
    if not @step.destroy
			flash[:alert] = @step.errors.full_messages 
		end
		respond_with(@step)
  end
  
  def update_row_order
    @step = Step.find(step_params[:step_id])
    @step.val_position = step_params[:row_order_position]
    @step.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:action, :note, :val, :step_status_id, :project_id, :step_id, :row_order_position, :due)
    end
end
