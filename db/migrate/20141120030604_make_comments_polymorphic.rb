class MakeCommentsPolymorphic < ActiveRecord::Migration
  def change
    rename_column :comments, :meal_id, :commentable_id
    add_column :comments, :commentable_type, :string, after: :commentable_id
  end
end
