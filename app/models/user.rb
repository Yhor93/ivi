class User < ApplicationRecord
  # Manejo seguro de contraseñas
  has_secure_password

  # Regex para validar formato de nombre (
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/

  # Regex para validar formato de email
  VALID_EMAIL_REGEX = /\A[\w\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Lista de nombre de emails prohibidos para registro
  RESERVED_NAMES = %w[admin root support superuser]

  # Validaciones
  validates :name,
            presence: true,
            length: { in: 3..10 },
            format: { with: VALID_NAME_REGEX, message: "solo puede contener letras y números" }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 30 },
            format: { with: VALID_EMAIL_REGEX }

  validates :password,
            presence: true,
            length: { minimum: 6 },
            on: :create

  validate :email_name_not_reserved

  before_save :downcase_attributes

  private

  def email_name_not_reserved
    username_email = email.to_s.split("@").first.downcase
    if RESERVED_NAMES.include?(username_email)
      errors.add(:email, "no puede comenzar con un nombre reservado como '#{username_email}'")
    end
  end

  def downcase_attributes
    self.name = name.downcase if name.present?
    self.email = email.downcase if email.present?
  end
end
