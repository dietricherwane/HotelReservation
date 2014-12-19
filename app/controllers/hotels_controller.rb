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
        @specification = Specification.new
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

end
