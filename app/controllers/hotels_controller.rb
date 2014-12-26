class HotelsController < ApplicationController

  layout 'administrator'

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
end
