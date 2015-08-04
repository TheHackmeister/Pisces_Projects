class StepStatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_step_status, only: [:show, :edit, :update, :destroy]
	respond_to :html	

  def index
    @step_statuses = StepStatus.all
		respond_with(@step_statuses)
  end

  def show
		respond_with(@step_status)
  end

  def new
    @step_status = StepStatus.new
		respond_with(@step_status)
  end

  def edit
		respond_with(@step_status)
  end

  def create
    @step_status = StepStatus.new(step_status_params)
    @step_status.save
		respond_with(@step_status)
  end

  def update
		@step_status.update(step_status_params)
		respond_with(@step_status)
  end

  def destroy
    @step_status.destroy
		respond_with(@step_status)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step_status
      @step_status = StepStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_status_params
      params.require(:step_status).permit(:text, :val)
    end
end
