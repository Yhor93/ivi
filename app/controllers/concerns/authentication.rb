module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    before_action :protect_pages

    private

      def set_current_user
        Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
      end

      def protect_pages
      return if Current.user
        redirect_to new_session_path, alert: t("authentication.sessions.errors_title.must_be_logged_in")
      end
  end
end
