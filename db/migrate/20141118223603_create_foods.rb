class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :servings, :energy
      t.float :fat, :protein

      t.timestamps
    end
  end
end
