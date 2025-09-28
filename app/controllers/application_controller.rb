class ApplicationController < ActionController::API
  include JwtAuthentication

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :cpf, :cnpj, :phone, :password, :password_confirmation ])
  end

  # Método para verificar se é uma ação do Devise
  def devise_controller?
    is_a?(::DeviseController) || self.class.name =~ /Devise/
  end
end
