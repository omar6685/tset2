class Product < ApplicationRecord

  validates :name, :price, presence: true
  validates :price, numericality: {greater_than: 5000, less_than: 1000000}
  mount_uploader :image, ImageUploader
  validates :name, length: { maximum: 30 }
  validates :name, length: { minimum: 3 }
  validates :model, length: { maximum: 30 }
  validates :model, length: { minimum: 3 }
  validates :description, length: { maximum: 1000 }
  validates :description, length: { minimum: 100 }

  
  BRAND = %w{ Apple Samsung Xiomi }
  COLOR = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Used  }



  def to_s
    name
  end


  # transform shopping cart products into an array of line items

  # create stripe product and assign to this product
  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  # stripe keeps products and prices separately. 
  # updating local prices would require to update or create stripe prices.
  # this is all additional complexity.
  # better just create new products.

  # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
  # after_update :create_and_assign_new_stripe_price, if: :saved_change_to_currency?

  # def create_and_assign_new_stripe_price
  #   price = Stripe::Price.create(product: self.stripe_product_id, unit_amount: self.price, currency: self.currency)
  #   update(stripe_price_id: price.id)
  # end

end
