class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end

  def set_locale
    # query string
    if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      # cabeçalho
      I18n.locale = extract_locale_from_accept_language || I18n.default_locale
    end
  end

  def extract_locale_from_accept_language
    # Pega o cabeçalho e extrai a primeira parte (ex: "pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3")
    lang = request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}(-[A-Z]{2})?/)&.first
    return nil unless lang

    # Pega a primeira parte do cabeçalho e verifica se está disponível
    parsed = lang.first.to_s
    I18n.available_locales.map(&:to_s).include?(parsed) ? parsed : nil
  end
end
