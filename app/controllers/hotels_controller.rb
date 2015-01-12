class HotelsController < ApplicationController

  before_filter :search_session_exists, only: [:room_details]

  layout :select_layout

  def select_layout
    if ["search", "room_details"].include?(action_name)
      return "user"
    else
      return "administrator"
    end
  end

  def index
    @hotel = Hotel.new

    init_index
  end

  def create
    @hotel = Hotel.new(params[:hotel])

    init_index

    if @hotel.save
      @hotel = Hotel.new
      flash.now[:success] = "L'hôtel a été créé."
    else
      flash.now[:error] = @hotel.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @hotels = Hotel.all
  end

  def edit
    @hotel = Hotel.find_by_id(params[:id])

    init_index

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @hotel = Hotel.find_by_id(params[:id])
    @hotel_name = @hotel.name

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @hotel.update(params[:hotel])
        flash.now[:success] = "L'hôtel: #{@hotel.name} a été mis à jour."
      else
        flash.now[:error] = @hotel.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_index

      render :edit
    end
  end

  def enable
    @hotel = Hotel.find_by_id(params[:id])

    enable_disable(true, 'activé')
  end

  def disable
    @hotel = Hotel.find_by_id(params[:id])

    enable_disable(false, 'désactivé')
  end

  def enable_disable(status, message)
    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @hotel.update_attribute(:published, status)
      @hotels = Hotel.all
      flash.now[:notice] = "L'hôtel #{@hotel.name} a été #{message}."
    end

    render :show
  end

  def init_index
    @country = Country.find_by_name("Côte d'Ivoire")
    @cities = City.where(country_id: @country.id)
  end

  ################################ Specification
  def specification
    @hotel = Hotel.find_by_id(params[:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @specification = @hotel.specifications.new
      init_specifications
    end
  end

  def create_specification
    @specification = Specification.new(params[:specification])
    @hotel = Hotel.find_by_id(params[:specification][:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @specification.save
        @specification = @hotel.specifications.new
        flash.now[:success] = "La spécification a été ajoutée à l'hôtel: #{@hotel.name}."
      else
        flash.now[:error] = @specification.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_specifications

      params[:specification][:hotel_id] = @hotel.id

      render :specification
    end
  end

  def specifications
    @hotel = Hotel.find_by_id(params[:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      init_specifications
      @specifications = @hotel.specifications
    end
  end

  def edit_specification
    @specification = Specification.find_by_id(params[:specification_id])

    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @hotel = @specification.hotel

      init_specifications
    end
  end

  def update_specification
    @specification = Specification.find_by_id(params[:specification_id])

    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @hotel = @specification.hotel
      if @specification.update(params[:specification])
        flash.now[:success] = "La spécification a été mise à jour."
      else
        flash.now[:error] = @specification.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_specifications

      render :edit_specification
    end
  end

  def enable_specification
    @specification = Specification.find_by_id(params[:specification_id])

    enable_disable_specification(true, 'activée')
  end

  def disable_specification
    @specification = Specification.find_by_id(params[:specification_id])

    enable_disable_specification(false, 'désactivée')
  end

  def enable_disable_specification(status, message)
    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @specification.update_attribute(:published, status)
      @hotel = @specification.hotel
      @city = @hotel.city
      @specifications = @hotel.specifications
      flash.now[:notice] = "La spécification #{@specification.name} a été #{message}."
    end

    render :specifications
  end

  def init_specifications
    @city = @hotel.city
    @specification_types = SpecificationType.where(published: [nil, true])
  end
  ################################ Specification

  ################################ Sub Specification
  def sub_specification
    @specification = Specification.find_by_id(params[:specification_id])

    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @sub_specification = @specification.sub_specifications.new
      init_sub_specifications
    end
  end

  def create_sub_specification
    @sub_specification = SubSpecification.new(params[:sub_specification])
    @specification = Specification.find_by_id(params[:sub_specification][:specification_id])

    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @sub_specification.save
        @sub_specification = @specification.sub_specifications.new
        flash.now[:success] = "La sous spécification a été ajoutée à la spécification: #{@specification.name}."
      else
        flash.now[:error] = @sub_specification.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_sub_specifications

      params[:sub_specification][:specification_id] = @specification.id

      render :sub_specification
    end
  end

  def sub_specifications
    @specification = Specification.find_by_id(params[:specification_id])

    if @specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      init_sub_specifications
      @sub_specifications = @specification.sub_specifications
    end
  end

  def edit_sub_specification
    @sub_specification = SubSpecification.find_by_id(params[:sub_specification_id])

    if @sub_specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @specification = @sub_specification.specification
      init_sub_specifications
    end
  end

  def update_sub_specification
    @sub_specification = SubSpecification.find_by_id(params[:sub_specification_id])

    if @sub_specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @sub_specification.update(params[:sub_specification])
        flash.now[:success] = "La sous spécification #{@sub_specification.description} a été mise à jour."
      else
        flash.now[:error] = @sub_specification.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end
      @specification = @sub_specification.specification
      init_sub_specifications

      render :edit_sub_specification
    end
  end

  def enable_sub_specification
    @sub_specification = SubSpecification.find_by_id(params[:sub_specification_id])

    enable_disable_sub_specification(true, 'activée')
  end

  def disable_sub_specification
    @sub_specification = SubSpecification.find_by_id(params[:sub_specification_id])

    enable_disable_sub_specification(false, 'désactivée')
  end

  def enable_disable_sub_specification(status, message)
    if @sub_specification.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @sub_specification.update_attribute(:published, status)
      @specification = @sub_specification.specification
      @sub_specifications = @specification.sub_specifications
      init_sub_specifications
      flash.now[:notice] = "La sous spécification #{@sub_specification.description} a été #{message}."
    end

    render :sub_specifications
  end

  def init_sub_specifications
    @hotel = @specification.hotel
    @city = @hotel.city
  end
  ################################ Sub Specification

  ################################ Room type
  def room_type
    @hotel = Hotel.find_by_id(params[:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type = @hotel.room_types.new
      init_room_types
    end
  end

  def create_room_type
    @room_type = RoomType.new(params[:room_type])
    @hotel = Hotel.find_by_id(params[:room_type][:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @room_type.save
        @room_type = @hotel.room_types.new
        flash.now[:success] = "Le type de chambre a été ajouté à l'hôtel: #{@hotel.name}."
      else
        flash.now[:error] = @room_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_types

      params[:room_type][:hotel_id] = @hotel.id

      render :room_type
    end
  end

  def room_types
    @hotel = Hotel.find_by_id(params[:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      init_room_types
      @room_types = @hotel.room_types
    end
  end

  def edit_room_type
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @hotel = @room_type.hotel

      init_room_types
    end
  end

  def update_room_type
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @hotel = @room_type.hotel
      if @room_type.update(params[:room_type])
        flash.now[:success] = "Le type de chambre a été mis à jour."
      else
        flash.now[:error] = @room_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_types

      render :edit_room_type
    end
  end

  def enable_room_type
    @room_type = RoomType.find_by_id(params[:room_type_id])

    enable_disable_room_type(true, 'activé')
  end

  def disable_room_type
    @room_type = RoomType.find_by_id(params[:room_type_id])

    enable_disable_room_type(false, 'désactivé')
  end

  def enable_disable_room_type(status, message)
    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type.update_attribute(:published, status)
      @hotel = @room_type.hotel
      @city = @hotel.city
      @room_types = @hotel.room_types
      flash.now[:notice] = "Le type de chambre #{@room_type.name} a été #{message}."
    end

    render :room_types
  end

  def init_room_types
    @city = @hotel.city
    @bed_types = BedType.where(published: [nil, true])
  end
  ################################ Room type

  def search
    if check_search_session_variables(params)
      set_search_session_variables(params)

      terms = session[:search_hotel_terms].strip.split

      cities_sql = search_cities_sql(terms)

      hotel_sql = ""
      @hotels = []

      terms.each do |term|
        hotel_sql << "(name ILIKE '%#{term}%' OR address ILIKE '%#{term}%') AND "
      end
      hotel_sql = "(#{hotel_sql[0..-5]})"

      unfiltered_hotels = Hotel.where("#{cities_sql} #{hotel_sql} AND published IS NOT FALSE")

      if unfiltered_hotels.blank?
        @hotels = nil
      else
        unfiltered_hotels.each do |unfiltered_hotel|
          available_rooms = unfiltered_hotel.room_types.where("number_of_persons = #{session[:search_hotel_adult]} AND available_rooms > 0 AND published IS NOT FALSE")
          unless available_rooms.blank?
            @hotels << unfiltered_hotel
          end
        end
      end
      @hotels_count = @hotels.count rescue 0

      if @hotels.blank?
        flash.now[:notice] = "Aucun résultat n'a été trouvé. Veuillez effectuer une autre recherche."
      else
        flash.now[:success] = "#{@hotels_count} hôtel#{@hotels_count > 1 ? "s ont été trouvés" : " a été trouvé"}."
      end

      @duke = params.inspect
    else
      flash[:notice] = "Veuillez entrer une destination, un nom d'hôtel ou un lieu d'intérêt, choisir le nombre de pensionnaires et indiquer la date."
      redirect_to root_path
    end
  end

  # Check if some terms exist in cities
  def search_cities_sql(terms)
    cities_id = ""
    cities_sql = ""
    terms.each do |term|
      cities_sql << "name ILIKE '%#{term}%' OR "
    end
    cities = City.where("#{cities_sql[0..-4]} AND published IS NOT FALSE")

    # Save cities ids
    unless cities.empty?
      cities.each do |city|
        cities_id << "#{city.id},"
      end
    end

    # Remove the coma in the end
    cities_id = cities_id.chop

    unless cities_id.blank?
      cities_sql = "city_id IN (#{cities_id}) AND "
    end

    return cities_sql
  end

  def set_search_session_variables(params)
    session[:search_hotel_terms] = params[:terms]
    session[:search_hotel_begin_date] = params[:begin_date]
    session[:search_hotel_end_date] = params[:end_date]
    session[:search_hotel_adult] = params[:post][:adults]
    session[:search_hotel_children] = params[:post][:children]
    session[:search_number_of_nights] = (Date.parse(session[:search_hotel_end_date]) - Date.parse(session[:search_hotel_begin_date])).to_i
  end

  # Returns true if terms and adult number exists
  def check_search_session_variables(params)
    if !params[:terms].blank? && (!params[:post][:adults].blank? rescue false) && !params[:begin_date].blank? && (Date.parse(params[:begin_date])) >= Date.today
      return true
    else
      return false
    end
  end

  def room_details
    @hotel = Hotel.find_by_id(params[:hotel_id])

    if @hotel.blank?
      render :file => "#{Rails.root}/public/user/404.html", :status => 404, :layout => false
    else
      @city = @hotel.city
      @country = @city.country
      @room_types = @hotel.room_types.where("number_of_persons = #{session[:search_hotel_adult]} AND available_rooms > 0").order("price ASC")
    end
  end

  def search_session_exists
    if session[:search_hotel_terms].blank?
      redirect_to root_path
    end
  end

end
