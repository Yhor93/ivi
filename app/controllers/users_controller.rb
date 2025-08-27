class UsersController < ApplicationController
  skip_before_action :protect_pages, only: [ :show, :favorites ]

  def show
    @user = User.find_by!(username: params[:username])
    @products = @user.products
  end

  def favorites
    @user = User.find_by!(username: params[:username])
    @favorite_products = @user.favorite_products.includes(:user)
  end
end
