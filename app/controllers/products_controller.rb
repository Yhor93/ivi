class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :protect_pages, only: %i[index show]

  # GET /products
  def index
    @categories = Category.order(name: :asc).load_async
    @products = FindProducts.new.call(product_params_index).load_async
  end

  # GET /products/:id
  def show; end
  # GET /products/:id/edit
  def edit
    authorize!(@product)
  end
  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Current.user.products.new(product_params)

    if @product.save
      redirect_to @product, notice: "Producto creado con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    authorize!(@product)
    if @product.update(product_params)
      redirect_to @product, notice: "Producto actualizado con éxito."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    authorize!(@product)
    @product.destroy
    redirect_to products_path, notice: "Producto eliminado con éxito."
  end

  private

  def set_product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :photo, :category_id)
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :sort)
  end
end
