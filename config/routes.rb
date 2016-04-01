Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'layouts#index'

  resources :votes do 
    collection do
      delete 'unvote'
      get 'my-votes', to: 'votes#my_votes'
    end
  end
  resources :shows do 
    collection do 
      get 'votes-page', to: 'shows#vote_page'
      get 'this-week', to:'shows#this_week'
      get 'rand'
      post 'new-random', to:'shows#new_random'
    end

    member do 
      post 'make-ongoing', to: 'shows#make_ongoing'
    end
  end

  resources :users do 
    collection do 
      get 'sign-in', to: 'users#sign_in'
    end
  end

  get 'animelist/search' => 'animelist#search'


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
