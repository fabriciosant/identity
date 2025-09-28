# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :cpf, :cnpj, :phone, :created_at, :updated_at
end
