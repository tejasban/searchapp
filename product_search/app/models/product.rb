class Product < ApplicationRecord
  validates :title, presence: true
  searchable do
    text :title, :default_boost => 2
    text :description
    text :tags
    text :country
    double :price
  end
end
