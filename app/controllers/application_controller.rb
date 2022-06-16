# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages

  around_action :switch_locale
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:warning] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_to(root_path)
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
