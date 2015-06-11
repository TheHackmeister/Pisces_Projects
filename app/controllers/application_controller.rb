class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#  before_action :authenticate_user!
	before_action :authorize

  # Fix for CanCan 
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)

	private 
	
	def authorize
		if params[:format] != 'json'
			authenticate_user!
		else
			# If it has cookies error out?
			# Figure out my own authentication.
		end
	end
end
