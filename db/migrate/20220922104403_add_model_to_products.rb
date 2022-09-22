class AddModelToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :model, :string
  end
end
