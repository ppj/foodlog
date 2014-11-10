class RenameBodyColumnInMeals < ActiveRecord::Migration
  def change
    rename_column :meals, :body, :description
  end
end
