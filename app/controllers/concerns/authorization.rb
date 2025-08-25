module Authorization
  extend ActiveSupport::Concern

  included do
      class NotAuthorized < StandardError; end

      rescue_from NotAuthorized do
        redirect_to products_path, alert: t("authorization.not_allowed")
      end

      private

      def authorize!(record = nil)
        is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).public_send(action_name)
        raise NotAuthorized unless is_allowed
      end
  end
end
