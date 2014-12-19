class CountriesController < ApplicationController

  layout 'administrator'

  def show
    @countries = Country.all
  end

  def cities
    @country = Country.find_by_id(params[:country_id])

    if @country.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @cities = @country.cities
    end
  end

  def enable
    @country = Country.find_by_id(params[:id])

    enable_disable(true, 'activé')
  end

  def disable
    @country = Country.find_by_id(params[:id])

    enable_disable(false, 'désactivé')
  end

  def enable_disable(status, message)
    if @country.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @country.update_attribute(:published, status)
      @countries = Country.all
      flash.now[:notice] = "Le pays #{@country.name} a été #{message}."
    end

    render :show
  end
end
