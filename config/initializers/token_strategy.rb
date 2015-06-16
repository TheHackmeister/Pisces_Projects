require 'devise/strategies/authenticatable'

module Devise
	module Strategies
		class TokenAuth < Authenticatable
			def authenticate!
				
				puts "\nIn authenticate\n"
				user = User.find_by_email(params['email'])	
				if user == nil
					fail!("Couldn't find user")
				elsif user.token == ""
					fail!("User does not have a token.")
				elsif user.token == params['token']
					success!(user)
				else
					fail!("Could not validate token")
				end
				#u = User.authenticate(params['email'], params['token'])
				#u.nil ? fail!("Could not log in") : success!(u)
			end

			# Only valid for json pages.
			def valid?
				((request.format.symbol == :json) || (params["format"] != nil && params["format"] == "json")) && params["email"]
			end
		end
		Warden::Strategies.add(:token_auth, Devise::Strategies::TokenAuth)
	end
end

