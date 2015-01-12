class Misc < ActiveRecord::Base
  # Relationships
  has_many :room_type_variation_miscs
  has_many :room_type_variations, through: :room_type_variation_miscs

  # Commodités

  # Accessible fields
  attr_accessible :description, :icon, :published

  # Paperclip config
  has_attached_file :icon, :styles => { :medium => "300x300>", :icon => "24x24>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/

  # Relationships
  has_many :room_type_variation_miscs

  # Scopes
  default_scope {order("description ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    description: 'La description',
    icon: "L'icône"
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :description, :icon, presence: true
  validates :description, length: {in: 2..100}
  validates :description, uniqueness: true
end
