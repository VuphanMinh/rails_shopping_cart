class ProductsController < ApplicationController
  before_action :logged_in_shop, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.page(params[:page]).per(5)
    # debugger
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @shop_id = current_login.id
    @categories = current_login.categories
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = current_login.products.build(product_params)
    if @product.save
      flash[:success] = "New Product success!"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product is update"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product is deleted"
    redirect_to products_path
  end

  def logged_in_shop
    unless logged_in?
      flash[:danger] = "please log in"
      redirect_to login_url
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_ids)
  end
end
