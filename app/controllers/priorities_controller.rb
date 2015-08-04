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
    @priority.save
		respond_with(@priority)
  end

  def update
		@priority.update(priority_params)
		respond_with(@priority)
  end

  def destroy
		@priority.destroy
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
