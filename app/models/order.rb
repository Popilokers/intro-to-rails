class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items
  has_many :products, through: :order_items

  validates :customer_id, presence: true
end
