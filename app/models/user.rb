class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # Validações customizadas
  validates :email, presence: true, if: :email_required?
  validates :email, uniqueness: true, allow_blank: true
  validates :cpf, uniqueness: true, allow_nil: true
  validates :cnpj, uniqueness: true, allow_nil: true
  validates :phone, uniqueness: true, allow_nil: true

  validate :at_least_one_identifier

  def self.jwt_revoked?(payload, user)
    false
  end

  def self.revoke_jwt(payload, user)
  end

  # Método para logout (apenas para compatibilidade)
  def invalidate_token
    true
  end

  private

  def email_required?
    cpf.blank? && cnpj.blank? && phone.blank?
  end

  def at_least_one_identifier
    if email.blank? && cpf.blank? && cnpj.blank? && phone.blank?
      errors.add(:base, "Pelo menos um identificador deve ser fornecido (email, CPF, CNPJ ou telefone)")
    end
  end
end
