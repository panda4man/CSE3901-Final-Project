class LandingController < ApplicationController
	skip_before_filter :require_login
	layout "session"
  def index
  end
end
