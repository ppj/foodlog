class RenameMealsTitleColumnToName < ActiveRecord::Migration
  def change
    rename_column :meals, :title, :name
  end
end
