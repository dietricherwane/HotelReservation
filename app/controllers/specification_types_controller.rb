class SpecificationTypesController < ApplicationController
  layout 'administrator'

  def index
    @specification_type = SpecificationType.new
  end

  def create
    @specification_type = SpecificationType.new(params[:specification_type])

    if @specification_type.save
      @specification_type = SpecificationType.new
      flash.now[:success] = "La catégorie de spécification a été créée."
    else
      flash.now[:error] = @specification_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @specification_types = SpecificationType.all
  end

  def edit
    @specification_type = SpecificationType.find_by_id(params[:id])

    if @specification_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @specification_type = SpecificationType.find_by_id(params[:id])
    @specification_type_name = @specification_type.name

    if @specification_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @specification_type.update(params[:specification_type])
        flash.now[:success] = "La catégorie de spécification #{@specification_type.name} a été mis à jour."
      else
        flash.now[:error] = @specification_type.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      render :edit
    end
  end

  def enable
    @specification_type = SpecificationType.find_by_id(params[:id])

    enable_disable(true, 'activé')
  end

  def disable
    @specification_type = SpecificationType.find_by_id(params[:id])

    enable_disable(false, 'désactivé')
  end

  def enable_disable(status, message)
    if @specification_type.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @specification_type.update_attribute(:published, status)
      @specification_types = SpecificationType.all
      flash.now[:notice] = "La catégorie de spécification #{@specification_type.name} a été #{message}."
    end

    render :show
  end
end
