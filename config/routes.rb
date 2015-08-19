Rails.application.routes.draw do

  get 'login'    => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout'    => 'sessions#destroy'

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :courses do
    member do
      delete 'unregister'
      get 'register_in' => 'students#register_in'
      delete 'unregister_in' => 'students#unregister_in'
    end
  end
  resources :admins do
    collection do
      get 'login'     => 'sessions#new_admin'
      post 'login'    => 'sessions#create_admin'
      delete 'logout' => 'sessions#destroy_admin'
    end
  end
  resources :students do
    member do
      get 'courses' => 'courses#registered'
      get 'register_in' => 'courses#register_in'
      delete 'unregister_in' => 'courses#unregister_in'
    end
  end

  root 'static#home'
  get 'home' => 'static#root'

end
