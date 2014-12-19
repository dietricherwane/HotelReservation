class AdditionalBedTypesController < ApplicationController
  layout 'administrator'

  def index
    @additional_bed_type = AdditionalBedType.new
  end

  def create
    @additional_bed_type = AdditionalBedType.new(params[:additional_bed_type])

    if @additional_bed_type.save
      @additional_bed_type = AdditionalBedType.new
      flash.now[:success] = "Le type de lit supplémentaire a été créé."
    else
      flash.now[:error] = @additional_bed_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @additional_bed_types = AdditionalBedType.all
  end

  def edit
    @additional_bed_type = AdditionalBedType.find_by_id(params[:id])

    if @additional_bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @additional_bed_type = AdditionalBedType.find_by_id(params[:id])
    @additional_bed_type_name = @additional_bed_type.name

    if @additional_bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @additional_bed_type.update(params[:additional_bed_type])
        flash.now[:success] = "Le type de lit supplémentaire #{@additional_bed_type.name} a été mis à jour."
      else
        flash.now[:error] = @additional_bed_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      render :edit
    end
  end

  def enable
    @additional_bed_type = AdditionalBedType.find_by_id(params[:id])

    enable_disable(true, 'activé')
  end

  def disable
    @additional_bed_type = AdditionalBedType.find_by_id(params[:id])

    enable_disable(false, 'désactivé')
  end

  def enable_disable(status, message)
    if @additional_bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @additional_bed_type.update_attribute(:published, status)
      @additional_bed_types = AdditionalBedType.all
      flash.now[:notice] = "Le type de lit supplémentaire #{@additional_bed_type.name} a été #{message}."
    end

    render :show
  end

end
