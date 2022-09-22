class AddConditionToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :condition, :string
  end
end
