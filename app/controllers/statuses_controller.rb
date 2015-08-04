class StatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_status, only: [:show, :edit, :update, :destroy]
	respond_to :html

  def index
    @statuses = Status.all
		respond_with(@statuses)
  end

  def show
		respond_with(@status)
  end

  def new
    @status = Status.new
		respond_with(@status)
  end

  def edit
		respond_with(@status)
  end

  def create
    @status = Status.new(status_params)
		@status.save
		respond_with(@status)
  end

  def update
		@status.update(status_params)
		respond_with(@status)
  end

  def destroy
    @status.destroy
		respond_with(@status)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:text, :val)
    end
end
