class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname, :lastname, :username, :email, :timezone, :password_digest

      t.timestamps
    end
  end
end
