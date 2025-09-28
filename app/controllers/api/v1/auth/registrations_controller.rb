module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        def create
          user = User.new(user_params)

          if user.save
            token = generate_token_for(user)
            render json: {
              status: { code: 200, message: "Usuário criado com sucesso." },
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
              status: { code: 422, message: "Não foi possível criar o usuário.", errors: user.errors.full_messages }
            }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation, :cpf, :cnpj, :phone)
        end

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
