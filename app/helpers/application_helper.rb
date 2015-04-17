module ApplicationHelper
	def current_user=(user)
		@current_user = user
	end

	def current_user
		if session[:user_id]
			@current_user = User.find_by_id(session[:user_id])
			# Actually make sure we got the object
			# sometimes session exists but user doesn't
			if !@current_user.nil?
				return @current_user
			else 
				return false
			end
		end
	end

	def current_user?(user)
		user == current_user
	end
end
