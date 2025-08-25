class UsersController < ApplicationController
  skip_before_action :protect_pages, only: [ :show ]

  def show
    @user = User.find_by!(name: params[:username])
  end
end
