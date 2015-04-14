class GameMailer < ApplicationMailer
	def game_invite(from, to, game)
		@from = from
		@to = to
		@game  = game
		@url = 'http://google.com'
		mail(to: @to.email, subject: "Join #{@from.first_name} for a game of hangman?")
	end
end
