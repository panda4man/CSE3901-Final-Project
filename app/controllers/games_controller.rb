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

	def show
		@game = Game.find_by_id(params[:id])
	end

	def send_game
		respond_to do |format|
  		format.json { render json: @current_user }
  		format.html {redirect_to users_path}
  	end
  end

	def get_game
		respond_to do |format|
  		format.json { render json: @current_user }
  		format.html {redirect_to users_path}
  	end
	end

	private

	def game_params
  	params.require(:game).permit(:name, :first_user_id, :second_user_id, :first_user_status, :second_user_status, :winner, :invitee_email)
  end

  def send_link

  end
end
