class PrioritiesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_priority, only: [:show, :edit, :update, :destroy]
	respond_to :html

  def index
    @priorities = Priority.all
		respond_with(@priorities)
  end

  def show
		respond_with(@priority)
  end

  def new
    @priority = Priority.new
		respond_with(@priority)
  end

  def edit
		respond_with(@priority)
  end

  def create
    @priority = Priority.new(priority_params)
		
  #  respond_to do |format|
    if not @priority.save
			flash[:alert] = @priority.errors.full_messages 
		end
  #      format.html { redirect_to @priority, notice: 'Priority was successfully created.' }
  #      format.json { render :show, status: :created, location: @priority }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @priority.errors, status: :unprocessable_entity }
  #    end
  #  end
		
		respond_with(@priority)
  end

  def update
#    respond_to do |format|
      if not @priority.update(priority_params)
				flash[:alert] = @priority.errors.full_messages 
			end
#        format.html { redirect_to @priority, notice: 'Priority was successfully updated.' }
#        format.json { render :show, status: :ok, location: @priority }
#      else
#        format.html { render :edit }
#        format.json { render json: @priority.errors, status: :unprocessable_entity }
#      end
#    end
		respond_with(@priority)
  end

  def destroy
		if not @priority.destroy
			flash[:alert] = @priority.errors.full_messages 
		end
#    respond_to do |format|
#      format.html { redirect_to priorities_url, notice: 'Priority was successfully destroyed.' }
#      format.json { head :no_content }
#    end
		respond_with(@priority)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_priority
      @priority = Priority.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def priority_params
      params.require(:priority).permit(:text, :val)
    end
end
