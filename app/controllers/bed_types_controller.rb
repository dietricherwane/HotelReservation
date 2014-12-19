class BedTypesController < ApplicationController

  layout 'administrator'

  def index
    @bed_type = BedType.new
  end

  def create
    @bed_type = BedType.new(params[:bed_type])

    if @bed_type.save
      @bed_type = BedType.new
      flash.now[:success] = "Le type de lit a été créé."
    else
      flash.now[:error] = @bed_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @bed_types = BedType.all
  end

  def edit
    @bed_type = BedType.find_by_id(params[:id])

    if @bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @bed_type = BedType.find_by_id(params[:id])
    @bed_type_name = @bed_type.name

    if @bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @bed_type.update(params[:bed_type])
        flash.now[:success] = "Le type de lit #{@bed_type.name} a été mis à jour."
      else
        flash.now[:error] = @bed_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      render :edit
    end
  end

  def enable
    @bed_type = BedType.find_by_id(params[:id])

    enable_disable(true, 'activé')
  end

  def disable
    @bed_type = BedType.find_by_id(params[:id])

    enable_disable(false, 'désactivé')
  end

  def enable_disable(status, message)
    if @bed_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @bed_type.update_attribute(:published, status)
      @bed_types = BedType.all
      flash.now[:notice] = "Le type de lit #{@bed_type.name} a été #{message}."
    end

    render :show
  end

end
