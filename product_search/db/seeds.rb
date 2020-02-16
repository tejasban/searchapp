require 'json'
Product.delete_all if Rails.env.development?
products = JSON.parse(File.read("Products.json"))
products.each do |product|
  Product.create!(title: product["title"], description: product["description"], tags: product["tags"], price: product["price"], country: product["country"])
end

