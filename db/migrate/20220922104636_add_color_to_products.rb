class AddColorToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :color, :string
  end
end
