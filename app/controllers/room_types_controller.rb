class RoomTypesController < ApplicationController
  layout "administrator"

  def room_type_additional_bed
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_additional_bed = @room_type.room_type_additional_beds.new
      init_room_type_additional_beds
    end
  end

  def create_room_type_additional_bed
    @room_type_additional_bed = RoomTypeAdditionalBed.new(params[:room_type_additional_bed])
    @room_type = RoomType.find_by_id(params[:room_type_additional_bed][:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @room_type_additional_bed.save
        @room_type_additional_bed = @room_type.room_type_additional_beds.new
        flash.now[:success] = "Le type de lit supplémentaire a été ajouté à la chambre: #{@room_type.name}."
      else
        flash.now[:error] = @room_type_additional_bed.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_type_additional_beds

      params[:room_type_additional_bed][:room_type_id] = @room_type.id

      render :room_type_additional_bed
    end
  end

  def room_type_additional_beds
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      init_room_type_additional_beds
      @room_type_additional_beds = @room_type.room_type_additional_beds
    end
  end

  def edit_room_type_additional_bed
    @room_type_additional_bed = RoomTypeAdditionalBed.find_by_id(params[:room_type_additional_bed_id])

    if @room_type_additional_bed.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type = @room_type_additional_bed.room_type

      init_room_type_additional_beds
    end
  end

  def update_room_type_additional_bed
    @room_type_additional_bed = RoomTypeAdditionalBed.find_by_id(params[:room_type_additional_bed_id])

    if @room_type_additional_bed.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type = @room_type_additional_bed.room_type
      if @room_type_additional_bed.update(params[:room_type_additional_bed])
        flash.now[:success] = "Le type de lit supplémentaire a été mis à jour."
      else
        flash.now[:error] = @room_type_additional_bed.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_type_additional_beds

      render :edit_room_type_additional_bed
    end
  end

  def enable_room_type_additional_bed
    @room_type_additional_bed = RoomTypeAdditionalBed.find_by_id(params[:room_type_additional_bed_id])

    enable_disable_room_type_additional_bed(true, 'activé')
  end

  def disable_room_type_additional_bed
    @room_type_additional_bed = RoomTypeAdditionalBed.find_by_id(params[:room_type_additional_bed_id])

    enable_disable_room_type_additional_bed(false, 'désactivé')
  end

  def enable_disable_room_type_additional_bed(status, message)
    if @room_type_additional_bed.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_additional_bed.update_attribute(:published, status)
      @room_type = @room_type_additional_bed.room_type
      init_room_type_additional_beds
      @room_type_additional_beds = @room_type.room_type_additional_beds
      flash.now[:notice] = "Le type de lit supplémentaire #{@room_type_additional_bed.additional_bed_type.name} a été #{message}."
    end

    render :room_type_additional_beds
  end

  def init_room_type_additional_beds
    @hotel = @room_type.hotel
    @city = @hotel.city
    @additional_bed_types = AdditionalBedType.where(published: [nil, true])
  end

  def room_type_variation
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation = @room_type.room_type_variations.new
      init_room_type_variations
    end
  end

  def create_room_type_variation
    @room_type_variation = RoomTypeVariation.new(params[:room_type_variation])
    @room_type = RoomType.find_by_id(params[:room_type_variation][:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @room_type_variation.save
        @room_type_variation = @room_type.room_type_variations.new
        flash.now[:success] = "Une variante a été ajoutée à la chambre: #{@room_type.name}."
      else
        flash.now[:error] = @room_type_variation.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_type_variations

      params[:room_type_variation][:room_type_id] = @room_type.id

      render :room_type_variation
    end
  end

  def room_type_variations
    @room_type = RoomType.find_by_id(params[:room_type_id])

    if @room_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      init_room_type_variations
      @room_type_variations = @room_type.room_type_variations
    end
  end

  def edit_room_type_variation
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type = @room_type_variation.room_type

      init_room_type_variations
    end
  end

  def update_room_type_variation
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type = @room_type_variation.room_type
      if @room_type_variation.update(params[:room_type_variation])
        flash.now[:success] = "La variation de type de chambre a été mise à jour."
      else
        flash.now[:error] = @room_type_variation.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      init_room_type_variations

      render :edit_room_type_variation
    end
  end

  def enable_room_type_variation
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    enable_disable_room_type_variation(true, 'activé')
  end

  def disable_room_type_variation
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    enable_disable_room_type_variation(false, 'désactivé')
  end

  def enable_disable_room_type_variation(status, message)
    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation.update_attribute(:published, status)
      @room_type = @room_type_variation.room_type
      init_room_type_variations
      @room_type_variations = @room_type.room_type_variations
      flash.now[:notice] = "La variante a été #{message}."
    end

    render :room_type_variations
  end

  def init_room_type_variations
    @hotel = @room_type.hotel
    @city = @hotel.city
    @room_type_variations = RoomTypeVariation.where(published: [nil, true])
  end
end
