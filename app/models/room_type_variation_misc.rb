class RoomTypeVariationMisc < ActiveRecord::Base
  # Variations des types de chambres - Commodités

  # Accessible fields
  attr_accessible :room_type_variation_id, :misc_id, :published

  # Relationships
  belongs_to :room_type_variation
  belongs_to :misc

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    room_type_variation_id: 'La variante de type de chambre',
    misc_id: "La commodité"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Scopes
  default_scope {order("room_type_variation_id ASC")}

  # Validations
  validates :room_type_variation_id, :misc_id, presence: true
  validates :room_type_variation_id, uniqueness: {scope: [:misc_id]}
end
