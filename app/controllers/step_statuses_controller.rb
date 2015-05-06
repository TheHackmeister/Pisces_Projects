class StepStatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_step_status, only: [:show, :edit, :update, :destroy]

  # GET /step_statuses
  # GET /step_statuses.json
  def index
    @step_statuses = StepStatus.all
  end

  # GET /step_statuses/1
  # GET /step_statuses/1.json
  def show
  end

  # GET /step_statuses/new
  def new
    @step_status = StepStatus.new
  end

  # GET /step_statuses/1/edit
  def edit
  end

  # POST /step_statuses
  # POST /step_statuses.json
  def create
    @step_status = StepStatus.new(step_status_params)

    respond_to do |format|
      if @step_status.save
        format.html { redirect_to @step_status, notice: 'Step status was successfully created.' }
        format.json { render :show, status: :created, location: @step_status }
      else
        format.html { render :new }
        format.json { render json: @step_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /step_statuses/1
  # PATCH/PUT /step_statuses/1.json
  def update
    respond_to do |format|
      if @step_status.update(step_status_params)
        format.html { redirect_to @step_status, notice: 'Step status was successfully updated.' }
        format.json { render :show, status: :ok, location: @step_status }
      else
        format.html { render :edit }
        format.json { render json: @step_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /step_statuses/1
  # DELETE /step_statuses/1.json
  def destroy
    @step_status.destroy
    respond_to do |format|
      format.html { redirect_to step_statuses_url, notice: 'Step status was successfully destroyed.' }
      format.json { head :no_content }
    end
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
