class HomeController < ApplicationController

  layout :select_layout

  def select_layout
    if ["index", "contacts"].include?(action_name)
      return "user"
    else
      return "administrator"
    end
  end

  def index

  end

  def contacts

  end

end
