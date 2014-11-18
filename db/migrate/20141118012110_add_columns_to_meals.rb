class AddTitleColumnToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :title, :string
    add_column :meals, :slug, :string
  end
end
