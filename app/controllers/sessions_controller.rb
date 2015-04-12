class SessionsController < ApplicationController
	skip_before_filter :require_login
	layout "session"
	def new

	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user.nil?
			flash.now[:alert] = "Invalid email/password."
			render :new
		else
			sign_in user
			redirect_to user_url(user.id)
		end
	end

	def destroy
		sign_out
	end
end
