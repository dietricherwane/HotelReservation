class RoomType < ActiveRecord::Base
  # Types de chambres

  # Accessible fields
  attr_accessible :name, :bed_type_id, :hotel_id, :description, :number_of_persons, :available_rooms, :price, :cancellable, :cancellation_delay, :cancellation_details, :published

  # Relationships
  belongs_to :hotel
  belongs_to :bed_type
  has_many :room_type_additional_beds
  has_many :additional_bed_types, through: :room_type_additional_beds
  has_many :room_type_variations

  # Scopes
  default_scope {order("name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    name: 'Le nom',
    bed_type_id: 'Le type de chambre',
    hotel_id: "L'hôtel",
    description: 'La description',
    number_of_persons: 'Le nombre de personnes',
    available_rooms: 'Chambres disponibles',
    price: 'Le prix',
    cancellable: 'Annulation possible',
    cancellation_delay: "Le délai d'annulation",
    cancellation_details: "Les modalités d'annulation"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :name, :bed_type_id, :hotel_id, :number_of_persons, :available_rooms, :price, presence: true
  validates :cancellation_delay, :cancellation_details, presence: true, if: "cancellable == true"
  validates :name, length: {in: 2..100}
  validates :description, :cancellation_details, length: {minimum: 10, allow_blank: true}
  validates :number_of_persons, :available_rooms, :cancellation_delay, :price, numericality: {greater_than: 0, only_integer: true, allow_blank: true}

  validates :name, uniqueness: {scope: [:bed_type_id, :hotel_id]}
end
