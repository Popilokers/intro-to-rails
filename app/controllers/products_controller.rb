class ProductsController < ApplicationController
def index
@products = Product.all

# apply search filter
@products = @products.where("name LIKE ?", "%#{params[:query]}%") if params[:query].present?

# apply category filter
@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

# order and paginate
@products = @products.order(:name).page(params[:page]).per(25)


end


  def show
    @product = Product.find(params[:id])
  end
end
