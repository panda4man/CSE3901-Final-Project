class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.integer			:first_user_id
    	t.integer			:second_user_id
    	t.string			:name
      t.string      :word
      t.integer     :level, default: 1
      t.datetime    :start_time
      t.string      :invitee_email
    	t.integer			:first_user_progress, default: 0
    	t.integer			:second_user_progress, default: 0
      t.integer     :first_user_points, default: 500
      t.integer     :second_user_points, default: 500
      t.boolen      :first_user_done, default: false
      t.boolen      :second_user_done, default: false
    	t.integer			:winner, default: nil
      t.integer     :loser, default: nil
      t.integer     :player_one_draw, default: nil
      t.integer     :player_two_draw, default: nil
      t.timestamps null: false
    end
  end
end
