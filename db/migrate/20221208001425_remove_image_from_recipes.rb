class RemoveImageFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :image, :text
  end
end
