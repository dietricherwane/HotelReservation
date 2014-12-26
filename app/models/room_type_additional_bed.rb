class RoomTypeAdditionalBed < ActiveRecord::Base
  # Types de chambres

  # Accessible fields
  attr_accessible :room_type_id, :additional_bed_type_id, :published

  # Relationships
  belongs_to :room_type
  belongs_to :additional_bed_type

  # Scopes
  default_scope {order("room_type_id ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    room_type_id: 'Le type de chambre',
    additional_bed_type_id: 'Le type de lit supplémentaire'
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :room_type_id, :additional_bed_type_id, presence: true
  validates :additional_bed_type_id, uniqueness: {scope: [:room_type_id]}
end
