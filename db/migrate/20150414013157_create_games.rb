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
    	t.integer			:winner, default: nil
      t.timestamps null: false
    end
  end
end
