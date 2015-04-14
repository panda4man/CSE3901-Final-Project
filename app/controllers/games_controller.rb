class GamesController < ApplicationController
	def new
		@game = Game.new
	end

	def create
		@game = Game.new(game_params)
		if @game.valid?
			if @game.save
				@to = User.find_by_id(params[:second_user_id])
				GameMailer.game_invite(@current_user, @to).deliver_later
			else
				render :new
			end
		else
			flash.alert = "Unable to create game."
			render :new
		end
	end

	private

	def game_params
  	params.require(:game).permit(:name, :first_user_id, :second_user_id, :first_user_status, :second_user_status, :winner, :invitee_email)
  end

  def send_link

  end
end
