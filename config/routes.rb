Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  root 'home#index'

  get "contacts" => "home#contacts", as: :contacts

  get 'countries' => 'countries#show', as: :show_countries
  get 'country/disable/:id' => 'countries#disable', as: :disable_country
  get 'country/enable/:id' => 'countries#enable', as: :enable_country
  get 'country/cities/:country_id' => 'countries#cities', as: :cities_per_country

  get 'city' => 'cities#index', as: :city
  get 'cities' => 'cities#show', as: :cities
  post 'city/create' => 'cities#create', as: :create_city
  get 'city/create' => 'cities#index'
  get 'city/edit/:id' => 'cities#edit', as: :edit_city
  post 'city/update/:id' => 'cities#update', as: :update_city
  get 'city/update/:id' => 'cities#edit'
  get 'city/disable/:id' => 'cities#disable', as: :disable_city
  get 'city/enable/:id' => 'cities#enable', as: :enable_city

  get 'bed_type' => 'bed_types#index', as: :bed_type
  post 'bed_type/create' => 'bed_types#create', as: :create_bed_type
  get 'bed_type/create' => 'bed_types#index'
  get 'bed_types' => 'bed_types#show', as: :bed_types
  get 'bed_type/edit/:id' => 'bed_types#edit', as: :edit_bed_type
  post 'bed_type/update/:id' => 'bed_types#update', as: :update_bed_type
  get 'bed_type/update/:id' => 'bed_types#edit'
  get 'bed_type/disable/:id' => 'bed_types#disable', as: :disable_bed_type
  get 'bed_type/enable/:id' => 'bed_types#enable', as: :enable_bed_type

  get 'additional_bed_type' => 'additional_bed_types#index', as: :additional_bed_type
  post 'additional_bed_type/create' => 'additional_bed_types#create', as: :create_additional_bed_type
  get 'additional_bed_type/create' => 'additional_bed_types#index'
  get 'additional_bed_types' => 'additional_bed_types#show', as: :additional_bed_types
  get 'additional_bed_type/edit/:id' => 'additional_bed_types#edit', as: :edit_additional_bed_type
  post 'additional_bed_type/update/:id' => 'additional_bed_types#update', as: :update_additional_bed_type
  get 'additional_bed_type/update/:id' => 'additional_bed_types#edit'
  get 'additional_bed_type/disable/:id' => 'additional_bed_types#disable', as: :disable_additional_bed_type
  get 'additional_bed_type/enable/:id' => 'additional_bed_types#enable', as: :enable_additional_bed_type

  get 'specification_type' => 'specification_types#index', as: :specification_type
  post 'specification_type/create' => 'specification_types#create', as: :create_specification_type
  get 'specification_type/create' => 'specification_types#index'
  get 'specification_types' => 'specification_types#show', as: :specification_types
  get 'specification_type/edit/:id' => 'specification_types#edit', as: :edit_specification_type
  post 'specification_type/update/:id' => 'specification_types#update', as: :update_specification_type
  get 'specification_type/update/:id' => 'specification_types#edit'
  get 'specification_type/disable/:id' => 'specification_types#disable', as: :disable_specification_type
  get 'specification_type/enable/:id' => 'specification_types#enable', as: :enable_specification_type

  get 'misc' => 'miscs#index', as: :misc
  post 'misc/create' => 'miscs#create', as: :create_misc
  get 'misc/create' => 'miscs#edit'
  get 'miscs' => 'miscs#show', as: :miscs
  get 'misc/edit/:id' => 'miscs#edit', as: :edit_misc
  post 'misc/update/:id' => 'miscs#update', as: :update_misc
  get 'misc/update/:id' => 'miscs#edit'
  get 'misc/disable/:id' => 'miscs#disable', as: :disable_misc
  get 'misc/enable/:id' => 'miscs#enable', as: :enable_misc

  get 'administrator' => 'hotels#index', as: :hotel
  post 'hotel/create' => 'hotels#create', as: :create_hotel
  get 'hotel/create' => 'hotels#index'
  get 'hotels' => 'hotels#show', as: :hotels
  get 'hotel/edit/:id' => 'hotels#edit', as: :edit_hotel
  post 'hotel/update/:id' => 'hotels#update', as: :update_hotel
  get 'hotel/update/:id' => 'hotels#edit'
  get 'hotel/disable/:id' => 'hotels#disable', as: :disable_hotel
  get 'hotel/enable/:id' => 'hotels#enable', as: :enable_hotel

  get 'hotel/:hotel_id/specification' => 'hotels#specification', as: :hotel_specification
  post 'hotel/:hotel_id/specification/create' => 'hotels#create_specification', as: :hotel_create_specification
  get 'hotel/:hotel_id/specification/create' => 'hotels#specification'
  get 'hotel/:hotel_id/specifications' => 'hotels#specifications', as: :hotel_specifications
  get 'hotel/specification/edit/:specification_id' => 'hotels#edit_specification', as: :hotel_edit_specification
  post 'hotel/specification/update/:specification_id' => 'hotels#update_specification', as: :hotel_update_specification
  get 'hotel/specification/update/:specification_id' => 'hotels#edit_specification'
  get 'hotel/specification/enable/:specification_id' => 'hotels#enable_specification', as: :hotel_enable_specification
  get 'hotel/specification/disable/:specification_id' => 'hotels#disable_specification', as: :hotel_disable_specification

  get 'hotel/specification/:specification_id/sub_specification' => 'hotels#sub_specification', as: :hotel_sub_specification
  post 'hotel/specification/:specification_id/sub_specification' => 'hotels#create_sub_specification', as: :hotel_create_sub_specification
  get 'hotel/specification/:specification_id/sub_specifications' => 'hotels#sub_specifications', as: :hotel_sub_specifications
  get 'hotel/specification/sub_specification/edit/:sub_specification_id' => 'hotels#edit_sub_specification', as: :hotel_edit_sub_specification
  post 'hotel/specification/sub_specification/update/:sub_specification_id' => 'hotels#update_sub_specification', as: :hotel_update_sub_specification
  get 'hotel/sub_specification/enable/:sub_specification_id' => 'hotels#enable_sub_specification', as: :hotel_enable_sub_specification
  get 'hotel/sub_specification/disable/:sub_specification_id' => 'hotels#disable_sub_specification', as: :hotel_disable_sub_specification

  get 'hotel/:hotel_id/room_type' => 'hotels#room_type', as: :hotel_room_type
  post 'hotel/:hotel_id/room_type/create' => 'hotels#create_room_type', as: :hotel_create_room_type
  get 'hotel/:hotel_id/room_type/create' => 'hotels#room_type'
  get 'hotel/:hotel_id/room_types' => 'hotels#room_types', as: :hotel_room_types
  get 'hotel/room_type/edit/:room_type_id' => 'hotels#edit_room_type', as: :hotel_edit_room_type
  post 'hotel/room_type/update/:room_type_id' => 'hotels#update_room_type', as: :hotel_update_room_type
  get 'hotel/room_type/update/:room_type_id' => 'hotels#edit_room_type'
  get 'hotel/room_type/enable/:room_type_id' => 'hotels#enable_room_type', as: :hotel_enable_room_type
  get 'hotel/room_type/disable/:room_type_id' => 'hotels#disable_room_type', as: :hotel_disable_room_type

  get 'room_type/:room_type_id/room_type_additional_bed' => 'room_types#room_type_additional_bed', as: :room_type_room_type_additional_bed
  post 'room_type/:room_type_id/room_type_additional_bed/create' => 'room_types#create_room_type_additional_bed', as: :room_type_create_room_type_additional_bed
  get 'room_type/:room_type_id/room_type_additional_bed/create' => 'room_types#room_type_additional_bed'
  get 'room_type/:room_type_id/room_type_additional_beds' => 'room_types#room_type_additional_beds', as: :room_type_room_type_additional_beds
  get 'room_type/room_type_additional_bed/edit/:room_type_additional_bed_id' => 'room_types#edit_room_type_additional_bed', as: :room_type_edit_room_type_additional_bed
  post 'room_type/room_type_additional_bed/update/:room_type_additional_bed_id' => 'room_types#update_room_type_additional_bed', as: :room_type_update_room_type_additional_bed
  get 'room_type/room_type_additional_bed/update/:room_type_additional_bed_id' => 'room_types#edit_room_type_additional_bed'
  get 'room_type/room_type_additional_bed/enable/:room_type_additional_bed_id' => 'room_types#enable_room_type_additional_bed', as: :room_type_enable_room_type_additional_bed
  get 'room_type/room_type_additional_bed/disable/:room_type_additional_bed_id' => 'room_types#disable_room_type_additional_bed', as: :room_type_disable_room_type_additional_bed

  get 'room_type/:room_type_id/room_type_variation' => 'room_types#room_type_variation', as: :room_type_room_type_variation
  post 'room_type/:room_type_id/room_type_variation/create' => 'room_types#create_room_type_variation', as: :room_type_create_room_type_variation
  get 'room_type/:room_type_id/room_type_variation/create' => 'room_types#room_type_variation'
  get 'room_type/:room_type_id/room_type_variations' => 'room_types#room_type_variations', as: :room_type_room_type_variations
  get 'room_type/room_type_variation/edit/:room_type_variation_id' => 'room_types#edit_room_type_variation', as: :room_type_edit_room_type_variation
  post 'room_type/room_type_variation/update/:room_type_variation_id' => 'room_types#update_room_type_variation', as: :room_type_update_room_type_variation
  get 'room_type/room_type_variation/update/:room_type_variation_id' => 'room_types#edit_room_type_variation'
  get 'room_type/room_type_variation/enable/:room_type_variation_id' => 'room_types#enable_room_type_variation', as: :room_type_enable_room_type_variation
  get 'room_type/room_type_variation/disable/:room_type_variation_id' => 'room_types#disable_room_type_variation', as: :room_type_disable_room_type_variation

  get "room_type_variation/:room_type_variation_id/misc" => "room_type_variations#misc", as: :room_type_variation_misc
  post "room_type_variation/:room_type_variation_id/misc/create" => "room_type_variations#create_misc", as: :create_room_type_variation_misc
  get "room_type_variation/:room_type_variation_id/miscs" => "room_type_variations#miscs", as: :room_type_variation_miscs
  get "room_type_variation/misc/:room_type_variation_misc_id/enable" => "room_type_variations#enable_misc", as: :enable_room_type_variation_misc
  get "room_type_variation/misc/:room_type_variation_misc_id/disable" => "room_type_variations#disable_misc", as: :disable_room_type_variation_misc

  ######## Users ########

  post "hotels/search" => "hotels#search", as: :search_hotel
  get "hotels/search" => "home#index"
  get "hotel/:hotel_id/rooms" => "hotels#room_details", as: :hotel_room_details

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get '*rogue_url', :to => 'errors#routing'
  post '*rogue_url', :to => 'errors#routing'
end
