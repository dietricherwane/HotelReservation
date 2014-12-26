class SubSpecification < ActiveRecord::Base
  # Liste des sous spécifications

  # Accessible fields
  attr_accessible :description, :specification_id, :published

  # Relationships
  belongs_to :specification

  # Scopes
  default_scope {order("specification_id ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    description: 'La description',
    specification_id: "La spécification"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :specification_id, :description, presence: true
  validates :description, length: {in: 2..100}
  validates :description, uniqueness: {scope: :specification_id}
end
