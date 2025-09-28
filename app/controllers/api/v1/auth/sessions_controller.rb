module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def create
          user = User.find_by(email: params[:user][:email])

          if user && user.valid_password?(params[:user][:password])
            # Gere o token manualmente
            token = generate_token_for(user)
            render json: {
              status: { code: 200, message: "Login efetuado com sucesso." },
              data: {
                id: user.id,
                email: user.email,
                cpf: user.cpf,
                cnpj: user.cnpj,
                phone: user.phone
              },
              token: token
            }
          else
            render json: {
              status: { code: 401, message: "Email ou senha inválidos." }
            }, status: :unauthorized
          end
        end

        def destroy
          render json: {
            status: { code: 200, message: "Logout efetuado com sucesso." }
          }
        end

        private

        def generate_token_for(user)
          payload = {
            user_id: user.id,
            exp: 30.days.from_now.to_i
          }
          JWT.encode(payload, Rails.application.credentials.devise_jwt_secret, "HS256")
        end
      end
    end
  end
end
