class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

	# Needed for API. If a user doesn't have a valid token, the authentication strategy will NOT roll over into the usual html auth.
	skip_before_action :verify_authenticity_token, if: :json_request? 
 
	# Fix for CanCan 
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :edit
  end
  
	private 
	
	def json_request?
		request.format.symbol == :json
	end
end
