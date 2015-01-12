class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    :email => "L'email",
    :firstname => "Le nom",
    :lastname => "Le prénom",
    :phone_number => "Le numéro de téléphone fixe",
    :mobile_number => "Le numéro de téléphone mobile",
    :password => "Le mot de passe",
    :password_confirmation => "La confirmation de mot de passe"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  attr_accessible :email, :firstname, :lastname, :phone_number, :mobile_number, :password, :password_confirmation, :confirmation_token

  # Validations
  validates :firstname, :lastname, presence: true
  validates :mobile_number, presence: true
  validates :firstname, :lastname, length: {in: 2..50}
  validates :phone_number, :mobile_number, length: {in: 6..15, allow_blank: true}
end
