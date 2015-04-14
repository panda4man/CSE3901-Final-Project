class GamesController < ApplicationController
	def new
		@game = Game.new
	end

	def create
		@game = Game.new(game_params)
		# Set first id to current user
		@game.first_user_id = @current_user.id
		# Grab second user by email
		@to = User.find_by_email!(@game.invitee_email)

		if @game.valid? && !@to.nil?
			@game.second_user_id = @to.id
			if @game.save
				GameMailer.game_invite(@current_user, @to, @game).deliver_later
				redirect_to @game, :flash => {:notice => "Invite successfully sent."}
			else
				flash.alert = "Unable to save game."
				render :new
			end
		else
			flash.alert = "Unable to create game."
			render :new
		end
	end

	def show
		@game = Game.find_by_id(params[:id])
		if @game.nil?
      redirect_to action: 'new', :flash => {:notice => "Error loading game."}
    end
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
