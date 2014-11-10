class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.text :body
      t.datetime :time

      t.timestamps
    end
  end
end
