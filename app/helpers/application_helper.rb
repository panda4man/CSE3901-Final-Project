module ApplicationHelper
	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def current_user?(user)
		user == current_user
	end
end
