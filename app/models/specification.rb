class Specification < ActiveRecord::Base
  # Spécifications

  # Accessible fields
  attr_accessible :name, :specification_type_id, :published, :user_id, :hotel_id

  # Relationships
  belongs_to :hotel
  belongs_to :specification_type
  has_many :sub_specifications

  # Scopes
  default_scope {order("specification_type_id ASC, name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    name: 'La spécification',
    specification_type_id: 'Le type de spécification',
    user_id: "L'auteur",
    hotel_id: "L'hôtel"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :name, :specification_type_id, :hotel_id, presence: true
  validates :name, length: {in: 2..100}
  validates :name, uniqueness: {scope: [:specification_type_id, :hotel_id]}
end
