module JwtAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, except: [ :create ]
  end

  private

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.devise_jwt_secret, true, algorithm: "HS256")
        user_id = decoded_token.first["user_id"]
        @current_user = User.find_by(id: user_id)

        unless @current_user
          render json: { error: "Usuário não encontrado" }, status: :unauthorized
          nil
        end

      rescue JWT::DecodeError
        render json: { error: "Token inválido" }, status: :unauthorized
        nil
      end
    else
      render json: { error: "Token não fornecido" }, status: :unauthorized
      nil
    end
  end

  def current_user
    @current_user
  end
end
