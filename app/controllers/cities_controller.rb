class CitiesController < ApplicationController

  layout 'administrator'

  def index
    @city = City.new

    init_index
  end

  def create
    @city = City.new(params[:city])
    init_index

    if @city.save
      @city = City.new
      flash.now[:success] = "La ville a été créée."
    else
      flash.now[:error] = @city.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @cities = City.all
  end

  def edit
    @city = City.find_by_id(params[:id])

    init_index

    if @city.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @city = City.find_by_id(params[:id])
    @city_name = @city.name

    if @city.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @city.update(params[:city])
        flash.now[:success] = "La ville #{@city.name} a été mise à jour."
      else
        flash.now[:error] = @city.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end
      init_index

      render :edit
    end
  end

  def enable
    @city = City.find_by_id(params[:id])

    enable_disable(true, 'activée')
  end

  def disable
    @city = City.find_by_id(params[:id])

    enable_disable(false, 'désactivée')
  end

  def enable_disable(status, message)
    if @city.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @city.update_attribute(:published, status)
      @cities = City.all
      flash.now[:notice] = "La ville #{@city.name} a été #{message}."
    end

    render :show
  end

  def init_index
    @countries = Country.where(published: [nil, true])
  end
end
