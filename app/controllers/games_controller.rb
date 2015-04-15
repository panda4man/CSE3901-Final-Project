class GamesController < ApplicationController
	def new
		@game = Game.new
	end

	def create
		@game = Game.new(game_params)

		if @game.valid?
			# Grab second user by email
			@to = User.find_by_email(@game.invitee_email)

			# If we found the user by email
			if !@to.nil?
				# Set first id to current user
				@game.first_user_id = @current_user.id
				# Set the second id to the invited users id
				@game.second_user_id = @to.id

				# Save the game object
				if @game.save
					GameMailer.game_invite(@current_user, @to, @game).deliver_later
					redirect_to @game, :flash => {:notice => "Invite successfully sent."}
				else
					flash.alert = "Unable to save game."
					render :new
				end
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

	# This method handles posts to update the current game state
	def update_game
		game = Game.find_by_id(params[:id])
		if !game.nil?
			game.first_user_progress = params[:first_user_progress]
			game.second_user_progress = params[:second_user_progress]
			game.save
			respond_to do |format|
	  		format.json { render json: game }
	  		format.html {redirect_to root_path}
	  	end
		else
			respond_to do |format|
	  		format.json { render json: {:error => true} }
	  		format.html {redirect_to root_path}
	  	end
		end
  end

  # This method handles fetching the game state by id
	def get_game
		game = Game.find_by_id(params[:id])
		respond_to do |format|
  		format.json { render json: game }
  		format.html {redirect_to root_path}
  	end
	end

	private

	def game_params
  	params.require(:game).permit(:name, :first_user_id, :second_user_id, :first_user_progress, :second_user_progress, :word, :level, :winner, :invitee_email)
  end

  # Levels go from 1-5
  # 1 being the easiest and five being the hardest.
  def random_word(level)
  	level_one = Array.new
  	level_two = Array.new
  	level_three = Array.new
  	level_four = Array.new
  	level_five = Array.new

  	case level
  	when 1
  		puts "one"
  	when 2 
  		puts "two"
  	when 3
  		puts "three"
  	when 4
  		puts "four"
  	when 5
  		puts "give"
  	else
  		puts "error?"
  	end
  end
end
