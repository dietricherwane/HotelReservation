class City < ActiveRecord::Base
  # Villes

  # Accessible fields
  attr_accessible :name, :country_id, :published

  # Relationships
  belongs_to :country
  has_many :hotels

  # Scopes
  default_scope {order("name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    name: 'Le nom',
    country_id: 'Le pays'
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :name, :country_id, presence: true
  validates :name, length: {in: 2..100}
  validates :name, uniqueness: true
end
