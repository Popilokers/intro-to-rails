class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])

    @items = @order.order_items

    @total = @items.sum(:price)
  end

end
