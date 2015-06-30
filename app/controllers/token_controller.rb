class TokenController < ApplicationController
#	load_and_authorize_resource
	respond_to :json
	skip_before_action :authenticate_user!, :only => [:show, :update]
	before_action :authorize, :only => [:show, :update]

  def show
		@user = current_user
  end

	def update
		@user = current_user
		@user.create_token
		render "show" # No reason to duplicate show when that's what is being displayed anyway. 
	end

	private

	def authorize
		if params[:email] == nil then return end

		if params[:password] != nil
			user = User.find_by_email(params[:email])
			if user.token == "" then user.create_token end
			sign_in user if user.valid_password?(params[:password])
		end
		authenticate_user!
	end
end
