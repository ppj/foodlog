class AddCreatorToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :creator_id, :integer, after: :protein
    change_column :foods, :slug, :string, after: :creator_id
  end
end
