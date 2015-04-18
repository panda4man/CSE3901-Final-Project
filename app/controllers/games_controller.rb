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
				# Set the word to the random word according to level
				@game.word = random_word(@game.level)
				
				# Save the game object
				if @game.save
					GameMailer.game_invite(@current_user, @to, @game).deliver_later
					redirect_to @game, layout: "game", :flash => {:notice => "Invite successfully sent."}
				else
					flash.alert = "Unable to save game."
					render :new
				end
			else
				flash.alert = "Unable to send email to user. Does not exist"
				render :new
			end
		else
			flash.alert = "Unable to create game."
			render :new
		end
	end

	def show
		@game = Game.find_by_id(params[:id])
		@first_user = User.find_by_id(@game.first_user_id)
		@second_user = User.find_by_id(@game.second_user_id)
		if @game.nil?
      redirect_to users_path, :flash => {:notice => "Error loading game."}
    else
    	if @game.stop? || @game.game_over?
    		redirect_to users_path, :flash => {:notice => "Game is over!"}
    	else
    		render layout: "game"
    	end
    end
	end

	# This method handles posts to update the current game state
	def update_game
		game = Game.find_by_id(params[:id])
		turn = params[:turn].to_i
		first_user_misses = params[:first_user_misses].to_i
		second_user_misses = params[:second_user_misses].to_i
		game_over = params[:game_over].to_s == "false" ? false : true 

		if !game.nil? && !game.stop?
			if !game_over
				# Update game params
				if turn.eql?(0)
					turn = 1
				else
					turn = 0
				end
				game.update_attributes(:turn => turn, :first_user_misses => first_user_misses, :second_user_misses => second_user_misses)
				respond_to do |format|
		  		format.json { render json: game}
		  		format.html {redirect_to root_path}
				end
	  	else
	  		#when game is over
	  		game.update_attributes(:first_user_misses => first_user_misses, :second_user_misses => second_user_misses, :game_over => true, :stop => true, :winner => params[:winner].to_i)
	  		#update winners wins by 1
	  		winner = User.find_by_id(params[:winner])
	  		wins = winner.wins.nil? ? 0 : winner.wins
	  		winner.update_attribute(:wins, wins + 1)

	  		#get losers id and update losses by 1
	  		if winner.id == params[:first_user_id].to_i
	  			loser = User.find_by_id(params[:second_user_id])
	  			losses = loser.losses.nil? ? 0 : loser.losses
	  			loser.update_attribute(:losses, losses + 1)
	  		else
	  			loser = User.find_by_id(params[:first_user_id])
	  			losses = loser.losses.nil? ? 0 : loser.losses
	  			loser.update_attribute(:losses, losses + 1)
	  		end
	  		respond_to do |format|
	  			format.json { render json: game }
	  			format.html {redirect_to root_path}
	  		end
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
  	params.require(:game).permit(:name, :first_user_id, :second_user_id, :game_over, :turn, :word, :level, :winner, :invitee_email)
  end

  # Levels go from 1-5
  # 1 being the easiest and five being the hardest.
  def random_word(level)
		# initialize constant arrays
		level_one = ["word", "find", "true", "read", "like", "note", "data", "ruby", "code", "show"]
		level_two = ["trees", "dizzy", "movie", "image", "media", "store", "phone", "false", "glare", "stone"]
		level_three = ["letter", "random", "english", "chrome", "device", "assign", "design", "search", "encode", "several"]
		level_four = ["plebian", "picture", "science", "execute", "message", "missing", "storage", "project", "history", "setting"]
		level_five = ["atrophy", "tutorial", "computer", "generate", "internet", "bookmark", "register", "download", "language", "important"]

		# get random integer 0-9
		prng = Random.new
		rand = prng.rand(10)
	
		# return word in array accordingly
  	case level	
		when 1
			return level_one[rand]
		when 2
			return level_two[rand]
		when 3
			return level_three[rand]
		when 4
			return level_four[rand]
		when 5
			return level_five[rand]
		else
			return false
  	end
	end
end
