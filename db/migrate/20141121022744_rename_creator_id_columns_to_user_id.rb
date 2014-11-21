class RenameCreatorIdColumnsToUserId < ActiveRecord::Migration
  def change
    rename_column :comments, :creator_id, :user_id
    rename_column :foods, :creator_id, :user_id
  end
end
