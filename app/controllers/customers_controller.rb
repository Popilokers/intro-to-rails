class CustomersController < ApplicationController
def index
  if params[:customer_query].present?
    @customers = Customer.where("first_name||' '||last_name LIKE ?", "%#{params[:customer_query]}%").order(:last_name)
  else
    @customers = Customer.all.order(:last_name)
  end

  @customers = @customers.page(params[:page]).per(25).order(:last_name) # if using Kaminari
end

  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
    @orders = @orders.page(params[:page]).per(5)
  end


end
