class Hotel < ActiveRecord::Base
  # Hôtels

  # Accessible fields
  attr_accessible :name, :stars, :address, :longitude, :latitude, :phone_number, :mobile_number, :email, :website, :description, :published, :location_description, :rooms_description, :terms, :user_id, :front, :city_id, :authorization_number

  # Paperclip config
  has_attached_file :front, :styles => { :medium => "300x300>", :small => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :front, :content_type => /\Aimage\/.*\Z/

  # Relationships
  belongs_to :city
  has_many :galleries
  has_many :specifications
  has_many :room_types

  # Scopes
  default_scope {order("name ASC")}

  # Renaming attributes into more friendly text
  HUMANIZED_ATTRIBUTES = {
    authorization_number: "Le numéro d'autorisation",
    name: 'Le nom',
    stars: 'La classe',
    address: "L'adresse",
    longitude: 'La longitude',
    latitude: 'La latitude',
    phone_number: 'Le numéro de téléphone fixe',
    mobile_number: 'Le numéro de téléphone mobile',
    email: "L'email",
    website: 'Le site web',
    city_id: 'La ville',
    description: 'La description',
    location_description: 'La situation géographique',
    rooms_description: 'La description des chambres',
    terms: 'Termes et conditions',
    user_id: 'Créé par',
    front: 'La photo descriptive'
  }

  # Using friendly attribute name if it exists and default name otherwise
  def self.human_attribute_name(attr, option = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  # Validations
  validates :front, :authorization_number, :name, :stars, :address, :longitude, :latitude, :phone_number, :description, :location_description, :rooms_description, :terms, :city_id, presence: true
  validates :phone_number, :mobile_number, :stars, :longitude, :latitude, numericality: {allow_blank: true}
  validates :stars, numericality: {greater_than: 0, less_than: 11, only_integer: true}
  validates :phone_number, :mobile_number, length: {in: 8..13, allow_blank: true}
  validates :name, :address, length: {in: 2..100}
  validates :description, :location_description, :rooms_description, :terms, length: {minimum: 10}
  validates :email, format: {with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, multiline: true, allow_blank: true}
  validates :website, format: {with: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, multiline: true, allow_blank: true}
  validates :email, :website, uniqueness: {allow_blank: true}
  validates :authorization_number, uniqueness: true
  validates :authorization_number, length: {minimum: 3}
end
