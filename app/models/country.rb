class Country < ActiveRecord::Base
  # Pays

  # Accessible fields
  attr_accessible :name, :code, :published

  # Relationships
  has_many :cities

  # Scopes
  default_scope {order("name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    name: 'Le nom',
    code: 'Le code'
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :name, :code, presence: true
  validates :name, length: {maximum: 45}
  validates :code, length: {maximum: 3}
  validates :name, :code, uniqueness: true
end
