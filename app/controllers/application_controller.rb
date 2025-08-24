class ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  def locale_from_header
    request.env["HTTP_ACCEPT_LANGUAGE"].to_s.scan(/^[a-z]{2}/).first
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    return if Current.user

    redirect_to new_session_path, alert: t("authentication.sessions.errors_title.must_be_logged_in")
  end
end
