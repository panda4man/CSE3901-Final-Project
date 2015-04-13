class CreateLeaderBoards < ActiveRecord::Migration
  def change
    create_table :leader_boards do |t|

      t.timestamps null: false
    end
  end
end
