# frozen_string_literal: true

# == Route Map
#
#                                     Prefix Verb   URI Pattern                                                                              Controller#Action
#                                       root GET    /                                                                                        events#index {:active=>true}
#                                     public GET    /public(.:format)                                                                        sessions#new
#                                    signout GET    /signout(.:format)                                                                       sessions#destroy
#                          sessions_getroles GET    /sessions/getroles(.:format)                                                             sessions#getroles
#                  sessions_set_index_filter POST   /sessions/set_index_filter(.:format)                                                     sessions#set_index_filter
#                sessions_clear_index_filter POST   /sessions/clear_index_filter(.:format)                                                   sessions#clear_index_filter
#                 sessions_set_pause_refresh PUT    /sessions/set_pause_refresh(.:format)                                                    sessions#set_pause_refresh
#                             lost_and_found GET    /lost_and_found(.:format)                                                                lost_and_found#index
#                                      admin GET    /admin(.:format)                                                                         admin#index
#                                     banner GET    /banner(.:format)                                                                        application#banner
#                                admin_index GET    /admin(.:format)                                                                         admin#index
#                                     audits GET    /audits(.:format)                                                                        audits#index
#                                   contacts GET    /contacts(.:format)                                                                      contacts#index
#                                            POST   /contacts(.:format)                                                                      contacts#create
#                                new_contact GET    /contacts/new(.:format)                                                                  contacts#new
#                               edit_contact GET    /contacts/:id/edit(.:format)                                                             contacts#edit
#                                    contact GET    /contacts/:id(.:format)                                                                  contacts#show
#                                            PATCH  /contacts/:id(.:format)                                                                  contacts#update
#                                            PUT    /contacts/:id(.:format)                                                                  contacts#update
#                                conventions GET    /conventions(.:format)                                                                   conventions#index
#                                            POST   /conventions(.:format)                                                                   conventions#create
#                             new_convention GET    /conventions/new(.:format)                                                               conventions#new
#                            edit_convention GET    /conventions/:id/edit(.:format)                                                          conventions#edit
#                                 convention GET    /conventions/:id(.:format)                                                               conventions#show
#                                            PATCH  /conventions/:id(.:format)                                                               conventions#update
#                                            PUT    /conventions/:id(.:format)                                                               conventions#update
#                                departments GET    /departments(.:format)                                                                   departments#index
#                                            POST   /departments(.:format)                                                                   departments#create
#                             new_department GET    /departments/new(.:format)                                                               departments#new
#                            edit_department GET    /departments/:id/edit(.:format)                                                          departments#edit
#                                 department GET    /departments/:id(.:format)                                                               departments#show
#                                            PATCH  /departments/:id(.:format)                                                               departments#update
#                                            PUT    /departments/:id(.:format)                                                               departments#update
#                                            DELETE /departments/:id(.:format)                                                               departments#destroy
#                           duty_board_index GET    /duty_board(.:format)                                                                    duty_board#index
#                                            POST   /duty_board(.:format)                                                                    duty_board#create
#                             new_duty_board GET    /duty_board/new(.:format)                                                                duty_board#new
#                            edit_duty_board GET    /duty_board/:id/edit(.:format)                                                           duty_board#edit
#                                 duty_board GET    /duty_board/:id(.:format)                                                                duty_board#show
#                                            PATCH  /duty_board/:id(.:format)                                                                duty_board#update
#                                            PUT    /duty_board/:id(.:format)                                                                duty_board#update
#                                            DELETE /duty_board/:id(.:format)                                                                duty_board#destroy
#                          duty_board_groups GET    /duty_board_groups(.:format)                                                             duty_board_groups#index
#                                            POST   /duty_board_groups(.:format)                                                             duty_board_groups#create
#                       new_duty_board_group GET    /duty_board_groups/new(.:format)                                                         duty_board_groups#new
#                      edit_duty_board_group GET    /duty_board_groups/:id/edit(.:format)                                                    duty_board_groups#edit
#                           duty_board_group PATCH  /duty_board_groups/:id(.:format)                                                         duty_board_groups#update
#                                            PUT    /duty_board_groups/:id(.:format)                                                         duty_board_groups#update
#                                            DELETE /duty_board_groups/:id(.:format)                                                         duty_board_groups#destroy
#     duty_board_slot_duty_board_assignments GET    /duty_board_slots/:duty_board_slot_id/duty_board_assignments(.:format)                   duty_board_assignments#index
#                                            POST   /duty_board_slots/:duty_board_slot_id/duty_board_assignments(.:format)                   duty_board_assignments#create
#  new_duty_board_slot_duty_board_assignment GET    /duty_board_slots/:duty_board_slot_id/duty_board_assignments/new(.:format)               duty_board_assignments#new
# edit_duty_board_slot_duty_board_assignment GET    /duty_board_slots/:duty_board_slot_id/duty_board_assignments/:id/edit(.:format)          duty_board_assignments#edit
#      duty_board_slot_duty_board_assignment GET    /duty_board_slots/:duty_board_slot_id/duty_board_assignments/:id(.:format)               duty_board_assignments#show
#                                            PATCH  /duty_board_slots/:duty_board_slot_id/duty_board_assignments/:id(.:format)               duty_board_assignments#update
#                                            PUT    /duty_board_slots/:duty_board_slot_id/duty_board_assignments/:id(.:format)               duty_board_assignments#update
#                                            DELETE /duty_board_slots/:duty_board_slot_id/duty_board_assignments/:id(.:format)               duty_board_assignments#destroy
#                           duty_board_slots GET    /duty_board_slots(.:format)                                                              duty_board_slots#index
#                                            POST   /duty_board_slots(.:format)                                                              duty_board_slots#create
#                        new_duty_board_slot GET    /duty_board_slots/new(.:format)                                                          duty_board_slots#new
#                       edit_duty_board_slot GET    /duty_board_slots/:id/edit(.:format)                                                     duty_board_slots#edit
#                            duty_board_slot GET    /duty_board_slots/:id(.:format)                                                          duty_board_slots#show
#                                            PATCH  /duty_board_slots/:id(.:format)                                                          duty_board_slots#update
#                                            PUT    /duty_board_slots/:id(.:format)                                                          duty_board_slots#update
#                                            DELETE /duty_board_slots/:id(.:format)                                                          duty_board_slots#destroy
#                              export_events GET    /events/export(.:format)                                                                 events#export
#                              review_events GET    /events/review(.:format)                                                                 events#review
#                              sticky_events GET    /events/sticky(.:format)                                                                 events#sticky
#                              secure_events GET    /events/secure(.:format)                                                                 events#secure
#                                            GET    /events/tag/:tag(.:format)                                                               events#tag
#                        merge_events_events POST   /events/merge_events(.:format)                                                           events#merge_events
#                      search_entries_events GET    /events/search_entries(/page/:page)(.:format)                                            events#search_entries
#                                     events GET    /events(/page/:page)(.:format)                                                           events#index
#                                            GET    /events(.:format)                                                                        events#index
#                                            POST   /events(.:format)                                                                        events#create
#                                  new_event GET    /events/new(.:format)                                                                    events#new
#                                 edit_event GET    /events/:id/edit(.:format)                                                               events#edit
#                                      event GET    /events/:id(.:format)                                                                    events#show
#                                            PATCH  /events/:id(.:format)                                                                    events#update
#                                            PUT    /events/:id(.:format)                                                                    events#update
#                            login_log_index GET    /login_log(.:format)                                                                     login_log#index
#                       lost_and_found_index GET    /lost_and_found(.:format)                                                                lost_and_found#index
#                export_lost_and_found_items GET    /lost_and_found_items/export(.:format)                                                   lost_and_found_items#export
#            searchform_lost_and_found_items GET    /lost_and_found_items/searchform(.:format)                                               lost_and_found_items#searchform
#                       lost_and_found_items GET    /lost_and_found_items(.:format)                                                          lost_and_found_items#index
#                                            POST   /lost_and_found_items(.:format)                                                          lost_and_found_items#create
#                    new_lost_and_found_item GET    /lost_and_found_items/new(.:format)                                                      lost_and_found_items#new
#                   edit_lost_and_found_item GET    /lost_and_found_items/:id/edit(.:format)                                                 lost_and_found_items#edit
#                        lost_and_found_item GET    /lost_and_found_items/:id(.:format)                                                      lost_and_found_items#show
#                                            PATCH  /lost_and_found_items/:id(.:format)                                                      lost_and_found_items#update
#                                            PUT    /lost_and_found_items/:id(.:format)                                                      lost_and_found_items#update
#                          radio_admin_index GET    /radio_admin(.:format)                                                                   radio_admin#index
#                          radio_assignments POST   /radio_assignments(.:format)                                                             radio_assignments#create
#                           radio_assignment PATCH  /radio_assignments/:id(.:format)                                                         radio_assignments#update
#                                            PUT    /radio_assignments/:id(.:format)                                                         radio_assignments#update
#                                            DELETE /radio_assignments/:id(.:format)                                                         radio_assignments#destroy
#                    radio_assignment_audits GET    /radio_assignment_audits(.:format)                                                       radio_assignment_audits#index
#                      delindex_radio_groups GET    /radio_groups/delindex(.:format)                                                         radio_groups#delindex
#                               radio_groups GET    /radio_groups(.:format)                                                                  radio_groups#index
#                                            POST   /radio_groups(.:format)                                                                  radio_groups#create
#                            new_radio_group GET    /radio_groups/new(.:format)                                                              radio_groups#new
#                           edit_radio_group GET    /radio_groups/:id/edit(.:format)                                                         radio_groups#edit
#                                radio_group GET    /radio_groups/:id(.:format)                                                              radio_groups#show
#                                            PATCH  /radio_groups/:id(.:format)                                                              radio_groups#update
#                                            PUT    /radio_groups/:id(.:format)                                                              radio_groups#update
#                                            DELETE /radio_groups/:id(.:format)                                                              radio_groups#destroy
#                             checkout_radio GET    /radios/:id/checkout(.:format)                                                           radios#checkout
#                    select_department_radio GET    /radios/:id/select_department(.:format)                                                  radios#select_department
#                   search_volunteers_radios POST   /radios/search_volunteers(.:format)                                                      radios#search_volunteers
#                                     radios GET    /radios(.:format)                                                                        radios#index
#                                            POST   /radios(.:format)                                                                        radios#create
#                                  new_radio GET    /radios/new(.:format)                                                                    radios#new
#                                 edit_radio GET    /radios/:id/edit(.:format)                                                               radios#edit
#                                      radio GET    /radios/:id(.:format)                                                                    radios#show
#                                            PATCH  /radios/:id(.:format)                                                                    radios#update
#                                            PUT    /radios/:id(.:format)                                                                    radios#update
#                                            DELETE /radios/:id(.:format)                                                                    radios#destroy
#                                      roles GET    /roles(.:format)                                                                         roles#index
#                                            POST   /roles(.:format)                                                                         roles#create
#                                   new_role GET    /roles/new(.:format)                                                                     roles#new
#                                  edit_role GET    /roles/:id/edit(.:format)                                                                roles#edit
#                                       role GET    /roles/:id(.:format)                                                                     roles#show
#                                            PATCH  /roles/:id(.:format)                                                                     roles#update
#                                            PUT    /roles/:id(.:format)                                                                     roles#update
#                                            DELETE /roles/:id(.:format)                                                                     roles#destroy
#                                   sessions POST   /sessions(.:format)                                                                      sessions#create
#                                new_session GET    /sessions/new(.:format)                                                                  sessions#new
#                                    session DELETE /sessions/:id(.:format)                                                                  sessions#destroy
#                       change_password_user GET    /users/:id/change_password(.:format)                                                     users#change_password
#                                      users GET    /users(.:format)                                                                         users#index
#                                            POST   /users(.:format)                                                                         users#create
#                                   new_user GET    /users/new(.:format)                                                                     users#new
#                                  edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                                       user GET    /users/:id(.:format)                                                                     users#show
#                                            PATCH  /users/:id(.:format)                                                                     users#update
#                                            PUT    /users/:id(.:format)                                                                     users#update
#                                            DELETE /users/:id(.:format)                                                                     users#destroy
#                                   versions GET    /versions(.:format)                                                                      versions#index
#                volunteer_new_from_attendee POST   /volunteers/:volunteer_id/new_from_attendee(.:format)                                    volunteers#new_from_attendee
#                        associate_volunteer POST   /volunteers/:id/associate(.:format)                                                      volunteers#associate
#                         new_user_volunteer POST   /volunteers/:id/new_user(.:format)                                                       volunteers#new_user
#                       attendees_volunteers GET    /volunteers/attendees(.:format)                                                          volunteers#attendees
#        clear_all_radio_training_volunteers GET    /volunteers/clear_all_radio_training(.:format)                                           volunteers#clear_all_radio_training
#                                 volunteers GET    /volunteers(.:format)                                                                    volunteers#index
#                                            POST   /volunteers(.:format)                                                                    volunteers#create
#                              new_volunteer GET    /volunteers/new(.:format)                                                                volunteers#new
#                             edit_volunteer GET    /volunteers/:id/edit(.:format)                                                           volunteers#edit
#                                  volunteer GET    /volunteers/:id(.:format)                                                                volunteers#show
#                                            PATCH  /volunteers/:id(.:format)                                                                volunteers#update
#                                            PUT    /volunteers/:id(.:format)                                                                volunteers#update
#                                            DELETE /volunteers/:id(.:format)                                                                volunteers#destroy
#                                       vsps GET    /vsps(.:format)                                                                          vsps#index
#                                            POST   /vsps(.:format)                                                                          vsps#create
#                                    new_vsp GET    /vsps/new(.:format)                                                                      vsps#new
#                                   edit_vsp GET    /vsps/:id/edit(.:format)                                                                 vsps#edit
#                                        vsp PATCH  /vsps/:id(.:format)                                                                      vsps#update
#                                            PUT    /vsps/:id(.:format)                                                                      vsps#update
#                         rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#                  rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                         rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#                  update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                       rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

ConOnRails::Application.routes.draw do
  root controller: :events, action: :index, active: true

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  get '/public', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/sessions/getroles', to: 'sessions#getroles'
  post '/sessions/set_index_filter', to: 'sessions#set_index_filter'
  post '/sessions/clear_index_filter', to: 'sessions#clear_index_filter'
  put '/sessions/set_pause_refresh', to: 'sessions#set_pause_refresh'
  get '/lost_and_found', to: 'lost_and_found#index'
  get '/admin', to: 'admin#index'
  get '/banner', to: 'application#banner'

  resources :admin, only: [:index]
  resources :audits, only: [:index]
  resources :contacts, except: [:destroy]
  resources :conventions, except: [:destroy]
  resources :departments

  resources :duty_board
  resources :duty_board_groups, except: [:show]

  resources :duty_board_slots do
    resources :duty_board_assignments
  end

  resources :events, except: [:destroy], concerns: :paginatable do
    collection do
      get 'export', format: :csv
      get 'review'
      get 'sticky'
      get 'secure'
      get 'tag/:tag', action: :tag
      post 'merge_events'
      get 'search_entries(/page/:page)', action: :search_entries, as: 'search_entries'
    end
  end

  resources :login_log, only: [:index]
  resources :lost_and_found, only: [:index]
  resources :lost_and_found_items, except: [:destroy] do
    collection do
      get :export, format: :csv
      get :searchform
    end
  end

  resources :radio_admin, only: [:index]
  resources :radio_assignments, only: %i[create update destroy]
  resources :radio_assignment_audits, only: [:index]
  resources :radio_groups do
    collection do
      get 'delindex'
    end
  end
  resources :radios do
    member do
      get 'checkout'
      get 'select_department'
      # put 'create_assignment'
    end
    collection do
      post 'search_volunteers' # This is cheating
    end
  end

  resources :roles
  resources :sessions, only: %i[new create destroy]
  resources :users do
    member do
      get :change_password
    end
  end

  resources :versions, only: [:index]
  resources :volunteers do
    post 'new_from_attendee'
    member do
      post 'associate'
      post 'new_user'
    end
    collection do
      get 'attendees'
      get 'clear_all_radio_training'
    end
  end

  resources :vsps, except: %i[show destroy]

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
