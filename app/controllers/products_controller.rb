class ProductsController < ApplicationController
def index
  if params[:query].present?
    @products = Product.where("name LIKE ?", "%#{params[:query]}%").order(:name)
  else
    @products = Product.all.order(:name)
  end

  @products = @products.page(params[:page]).per(25).order(:name) # if using Kaminari
end


  def show
    @product = Product.find(params[:id])
  end
end
