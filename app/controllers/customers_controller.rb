class CustomersController < ApplicationController
  load_and_authorize_resource 
  def index
    params[:customer_name_search] = params.delete :customer_name

    @customers = Customer.filter(params.slice(:customer_name_search))
    respond_to do |format|
      format.html
      format.json {
        render :json => @customers
      }
    end
  end

  def show
    @customers = "One"
  end


  private
    def customerParams
      params.require(:customer).permit :customer_name
    end
    def filtering_params(params)
      params.slice(:customer_name)
    end
end
