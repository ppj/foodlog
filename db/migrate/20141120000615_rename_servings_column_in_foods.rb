class RenameServingsColumnInFoods < ActiveRecord::Migration
  def change
    rename_column :foods, :servings, :notes
    change_column :foods, :notes, :string
    add_column    :foods, :slug, :string
  end
end
