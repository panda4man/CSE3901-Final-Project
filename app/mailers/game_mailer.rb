class GameMailer < ApplicationMailer
	def game_invite(from, to)
		@from = from
		@to = to
		@url = 'http://google.com'
		mail(to: @to.email, subject: "Join #{@from.first_name} for a game of hangman?")
	end
end
