class StepsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = Step.new
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to @step, notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
        format.ajax {render :partial => 'show_single', :object => @step, :formats => [:html]}
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
        format.ajax {render :partial => 'bad_step', :object => @step, :formats => [:html]}
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url, notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
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
