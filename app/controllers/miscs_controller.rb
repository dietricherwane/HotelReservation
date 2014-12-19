class MiscsController < ApplicationController
  layout 'administrator'

  def index
    @misc = Misc.new
  end

  def create
    @misc = Misc.new(params[:misc])

    if @misc.save
      @misc = Misc.new
      flash.now[:success] = "La commodité a été créée."
    else
      flash.now[:error] = @misc.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
    end

    render :index
  end

  def show
    @miscs = Misc.all
  end

  def edit
    @misc = Misc.find_by_id(params[:id])

    if @misc.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def update
    @misc = Misc.find_by_id(params[:id])
    @misc_description = @misc.description

    if @misc.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      if @misc.update(params[:misc])
        flash.now[:success] = "La commodité: #{@misc.description} a été mise à jour."
      else
        flash.now[:error] = @misc.errors.full_messages.map{ |msg| "#{msg}<br />" }.join
      end

      render :edit
    end
  end

  def enable
    @misc = Misc.find_by_id(params[:id])

    enable_disable(true, 'activée')
  end

  def disable
    @misc = Misc.find_by_id(params[:id])

    enable_disable(false, 'désactivée')
  end

  def enable_disable(status, message)
    if @misc.blank?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    else
      @misc.update_attribute(:published, status)
      @miscs = Misc.all
      flash.now[:notice] = "La commodité #{@misc.description} a été #{message}."
    end

    render :show
  end
end
