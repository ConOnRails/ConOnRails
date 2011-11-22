ConOnRails::Application.routes.draw do
  root :to => 'events#active'
  resources :sessions, :only => [:new, :create, :destroy]
  match '/public', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  # events cannot be destroyed (and neither can entries). We consider this a legal record
  resources :events, except: [:destroy]

  # entries have no separate controller -- they're dependencies of events in all cases
 
  resources :lost_and_found, :only => [:index]
  match '/lost_and_found', to: 'lost_and_found#index'

  resources :lost_and_found_items, except: [:index, :destroy] do
    collection do
      get 'missing'
      get 'found'
      get 'searchform'
      get 'search'
    end
  end
  
  # TODO At some point, we want administrative versions of these
  #namespace :admin do
    resources :users
  #end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
