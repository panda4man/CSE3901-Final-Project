module SessionsHelper
	def sign_in(user)
		session[:user_id] = user.id
		current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		session[:user_id] = nil
		redirect_to login_path
	end

	def deny_access
		redirect_to login_path, :notice => "Please sign in."
	end
end
