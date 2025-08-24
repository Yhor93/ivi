class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages, only: %i[new create]
  def new
    # formulario de login
  end

  def create
    login_input = params[:login].to_s.downcase

    # Sintaxis con named parameters + case-insensitive
    user = User.find_by(
      "lower(name) = :login OR lower(email) = :login",
      login: login_input
    )

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_path, notice: t("authentication.sessions.notices.welcome", name: user.name)
    else
      redirect_to new_session_path, alert: t("authentication.sessions.errors_title.invalid_credentials")
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: t("authentication.sessions.notices.destroyed")
  end
end
