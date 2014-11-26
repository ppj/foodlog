class AddServingsToPlates < ActiveRecord::Migration
  def change
    add_column :plates, :servings, :integer
  end
end
