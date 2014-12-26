class SpecificationType < ActiveRecord::Base
  # Liste des spécifications

  # Accessible fields
  attr_accessible :name, :user_id, :published

  # Relationships
  belongs_to :user_id
  has_many :specifications

  # Scopes
  default_scope {order("name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    name: 'Le nom',
    user_id: "Créé par"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :name, presence: true
  validates :name, length: {in: 2..100}
  validates :name, uniqueness: true
end
