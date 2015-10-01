Rails.application.routes.draw do

  root 'events#index'

  devise_for :users

  resources :events, shallow: true do
    member do
      get 'vote'
    end

    resources :questions do
      resources :choices
    end
  end

  resources :votes

  get 'questions/:id/publish_question' => 'questions#publish_question', as: :questions_publish

  get 'questions/:id/clear_votes' => 'questions#clear_votes', as: :clear_votes

  # get 'events/:id/parse_event_id' => 'events#parse_event_id', as: :parse_event_id

  get 'enter_poll', to: 'events#parse_event_id', as: :parse_id

  # get 'exit', to: 'sessions#destroy', as: :logout

  # get "/404", :to => "errors#not_found"
  # get "/422", :to => "errors#unacceptable"
  # get "/500", :to => "errors#internal_error"
  get "*any", via: :all, to: "errors#not_found"

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
end
