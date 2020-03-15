class AddIndexToProductsCategories < ActiveRecord::Migration[6.0]
  def change
    add_index :products_categories, [:product_id, :category_id],  :unique => true
  end
end
