class LeaderBoardsController < ApplicationController
  def index
  	@users = User.all.order(wins: :desc)
  end
end
