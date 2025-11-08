class AddOrderDateToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :order_date, :date
  end
end
