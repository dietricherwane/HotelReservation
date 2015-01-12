class RoomTypeVariation < ActiveRecord::Base
  # Variations des types de chambres

  # Accessible fields
  attr_accessible :room_type_id, :cancellable, :cancellation_delay, :cancellation_details, :price, :published

  # Relationships
  belongs_to :room_type
  has_many :room_type_variation_miscs
  has_many :miscs, through: :room_type_variation_miscs

  # Scopes
  default_scope {order("room_type_id ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    room_type_id: 'Le type de chambre',
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
  validates :room_type_id, :price, presence: true
  validates :cancellation_delay, :cancellation_details, presence: true, if: "cancellable == true"
  validates :cancellation_details, length: {minimum: 4, allow_blank: true}
  validates :cancellation_delay, :price, numericality: {greater_than: 0, only_integer: true, allow_blank: true}
  #validates :room_type_id, uniqueness: {scope: [:cancellation, :cancellation_delay, :cancellation_details, :price]}

  # Callbacks
  before_save :format_cancellation_fields
  before_update :format_cancellation_fields

  private
  def format_cancellation_fields
    if self.cancellable == false
      self.cancellation_delay = nil
      self.cancellation_details = nil
    end
  end

end
