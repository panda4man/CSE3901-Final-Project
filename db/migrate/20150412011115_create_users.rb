class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to  :game, index:true
      t.string      :first_name
      t.string      :last_name
      t.string      :encrypted_password
      t.string      :salt
      t.string      :email,    :unique  =>   true
      t.string      :username,  :unique  =>   true
      t.integer     :wins
      t.integer     :losses

      t.timestamps null: false
    end
  end
end
