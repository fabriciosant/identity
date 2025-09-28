# app/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user, only: [ :show, :update, :destroy ]

      def show
        render json: {
          status: { code: 200, message: "User retrieved successfully." },
          data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
        }
      end

      def update
        if @user.update(user_params)
          render json: {
            status: { code: 200, message: "User updated successfully." },
            data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
          }
        else
          render json: {
            status: { code: 422, message: "User could not be updated.", errors: @user.errors.full_messages }
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: {
          status: { code: 200, message: "User deleted successfully." }
        }
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :cpf, :cnpj, :phone)
      end
    end
  end
end
