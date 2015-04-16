class LandingController < ApplicationController
	skip_before_filter :require_login
	layout "session"
	
	def index
  		
    	if not current_user
      		redirect_to login_path
    	else
      		redirect_to users_path
    	end
  
	end

end
