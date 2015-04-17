# :turn if 0 then first_user
# :turn if 1 then second_user
class CreateGames < ActiveRecord::Migration
	def change
		create_table :games do |t|
			t.string		:name
			t.integer		:level
			t.string		:invitee_email
			t.string		:word
			t.integer      	:turn, default: 0
			t.integer     	:first_user_id
			t.integer		:second_user_id
			t.integer		:first_user_misses, default: 0
			t.integer		:second_user_misses, default: 0
			t.integer		:winner
			t.boolean		:game_over, default: false
			t.boolean		:stop, default: false
			t.timestamps null: false
		end
	end
end
