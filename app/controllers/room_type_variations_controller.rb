class RoomTypeVariationsController < ApplicationController

  layout "administrator"

  def misc
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation_misc = @room_type_variation.room_type_variation_miscs.new

      init_miscs
    end
  end

  def create_misc
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation_misc = RoomTypeVariationMisc.new(params[:room_type_variation_misc])

      if @room_type_variation_misc.save
        @room_type_variation_misc = @room_type_variation.room_type_variation_miscs.new
        flash.now[:success] = "La commodité a été ajoutée."
      else
        flash.now[:error] = @room_type_variation_misc.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      params[:room_type_variation_misc][:room_type_variation_id] = @room_type_variation.id
      init_miscs
      render :misc
    end
  end

  def miscs
    @room_type_variation = RoomTypeVariation.find_by_id(params[:room_type_variation_id])

    if @room_type_variation.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation_miscs = @room_type_variation.room_type_variation_miscs

      @room_type = @room_type_variation.room_type
      @hotel = @room_type.hotel
      @city = @hotel.city
    end
  end

  def enable_misc
    @room_type_variation_misc = RoomTypeVariationMisc.find_by_id(params[:room_type_variation_misc_id])

    enable_disable_misc(true, "activée")
  end

  def disable_misc
    @room_type_variation_misc = RoomTypeVariationMisc.find_by_id(params[:room_type_variation_misc_id])

    enable_disable_misc(false, "désactivée")
  end

  def enable_disable_misc(status, message)
    if @room_type_variation_misc.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @room_type_variation_misc.update_attribute(:published, status)
      flash.now[:notice] = "La commodité #{@room_type_variation_misc.misc.description} a été #{message}."
      @room_type_variation = @room_type_variation_misc.room_type_variation
      @room_type_variation_miscs = @room_type_variation.room_type_variation_miscs
      @room_type = @room_type_variation.room_type
      @hotel = @room_type.hotel
      @city = @hotel.city
    end

    render :miscs
  end

  def init_miscs
    @miscs = Misc.where(published: [nil, true])
    @room_type = @room_type_variation.room_type
    @hotel = @room_type.hotel
    @city = @hotel.city
  end

end
