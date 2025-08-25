module Languaje
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    private

    def switch_locale(&action)
      I18n.with_locale(locale_from_header, &action)
    end

    def locale_from_header
      request.env["HTTP_ACCEPT_LANGUAGE"].to_s.scan(/^[a-z]{2}/).first
    end
  end
end
