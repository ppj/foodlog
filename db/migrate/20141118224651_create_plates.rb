class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.integer :meal_id, :food_id

      t.timestamps
    end
  end
end
