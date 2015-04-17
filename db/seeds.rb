# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create( first_name: 'player', last_name: 'one', encrypted_password: 'password', email: 'player1@players.com', username: 'player1' )

User.create( first_name: 'player', last_name: 'two', encrypted_password: 'password', email: 'player2@players.com', username: 'player2' )

