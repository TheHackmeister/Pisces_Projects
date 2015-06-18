class TokenController < ApplicationController
#	load_and_authorize_resource
	respond_to :json
	skip_before_action :authenticate_user!, :only => [:show]
	before_action :authorize, :only => [:show]

  def show
		@user = current_user
		# Auth goes here.
		# Need to setup route.
  end

	private

	def authorize
		if params[:email] == nil then return end

		if params[:password] != nil
			user = User.find_by_email(params[:email])
			sign_in user if user.valid_password?(params[:password])
		end
		authenticate_user!
	end
end
