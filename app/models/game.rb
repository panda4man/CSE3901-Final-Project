class Game < ActiveRecord::Base
	has_many :users

	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :name,						:presence		=>	true
	validates	:level,						:presence		=>	true
	validates	:invitee_email,		:presence		=> 	true,
						:format												=> 	{:with => email_regex}
end
