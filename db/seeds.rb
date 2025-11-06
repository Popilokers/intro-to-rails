# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'
require 'faker'


OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Customer.destroy_all



#reads all csv files

product_csv = Rails.root.join('db/products.csv')

customer_csv = Rails.root.join('db/customers.csv')

#puts data into database

CSV.foreach(product_csv, headers: true) do |product|
  puts "Seeding product: #{product.to_h}"
    category = Category.find_or_create_by(category: product["category"])
    Product.create!(
      name: product["name"],
      price: product["price"].to_f,
      description: product["description"],
      stock_quantity: product["stock quantity"].to_i,
      category: category
    )

end

puts "Seeding complete! Total Products: #{Product.count}"

# Generate 10 fake categories
10.times do
  Category.find_or_create_by!(category: Faker::Commerce.department(max: 1, fixed_amount: true))
end

puts "Seeding complete! Total Categories: #{Category.count}"

CSV.foreach(customer_csv, headers: true) do |customer|
  puts "Seeding customer: #{customer.to_h}"
  Customer.create!(
    first_name: customer["first_name"],
    last_name: customer["last_name"],
    email: customer["email"]
  )
end

puts "Seeding complete! Total Customers: #{Customer.count}"

# creating fake orders

customers = Customer.all

10.times do
  customer = customers.sample
  order = Order.create!(customer: customer)
  puts "Created order ##{order.id} for customer #{customer.id} (#{customer.first_name} #{customer.last_name})"
end

puts "Seeding complete! Total Orders: #{Order.count}"

#order items

orders = Order.all
products = Product.all

# Generate order_items for each order
orders.each do |order|
  # Decide how many products to add to this order (1 to 5 products)
  rand(1..5).times do
    product = products.sample        # pick a random product
    quantity = rand(1..10)           # random quantity
    price = quantity * product.price             # price from the product

    OrderItem.create!(
      order: order,
      product: product,
      quantity: quantity,
      price: price
    )

    puts "Created order_item: Order ##{order.id}, Product ##{product.id}, Quantity #{quantity}, Price #{price}"
  end
end