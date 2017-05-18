Rails.application.routes.draw do

  devise_for :users
  #RUTAS:
  #/administracion                    Admin
  #/session/sign_in                   Login
  #/session/sign_out                  Cerrar sesión
  #/companies                         Listado de viveristas (empresas)
  #/companies/:id                     Detalle/perfil público del viverista (empresa)
  #/business_incubators               Listado de viveros
  #/business_incubators/:id           Detalle/perfil público del vivero
  #/articles                          Listado de noticias (por defecto categoría Incyde)
  #/articles/c/:category              Listado de noticia (de una categoría)
  #/articles/:id                      Detalle de noticia
  #/conferences                       Listado de conferencias (Si finalmente lo hay)
  #/conferences/:id                   Conferencia (Página con el iframe)
  #/page/legal_conditions             Condiciones legales

  mount RailsAdmin::Engine => '/administracion', as: 'rails_admin'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "home#index"

  concern :likeable do
    member do
      get 'toggle_like'
    end
  end

  resources :companies, only: [:index, :show] do
    get :autocomplete_sector_name, :on => :collection
    get :autocomplete_province_name, :on => :collection
  end
  resources :business_incubators, only: [:index, :show]
  resources :articles, only: [:index, :show], concerns: :likeable do
    collection do
      get 'c/:category' => 'articles#index', as: 'category'
    end
  end
  resources :conferences, only: [:index, :show]
  resources :seminars, only: [:index]
  resources :messages, only: [:index, :create, :update] do
    get :autocomplete_user_name, :on => :collection
  end

  resource :profile, only: [:edit, :update]
	resources :file_uploaders, only: [:index, :create, :destroy]
	resources :switch_users, only: [:index, :show]
	resources :static_pages, only: [], path: 'page'  do
    collection do
      get 'legal_conditions'
    end
  end
  resources :city_selects, only: [] do
    member do
      get 'regions'
      get 'provinces'
      get 'cities'
    end
  end



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
end
