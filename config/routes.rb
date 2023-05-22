Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root 'assers#welcome'
  # resources :assers
  # resources :stores
  resources :assers do
    resources :stories
  end
  

  # resources :assers do
  #   collection do
  #     get 'filter'
  #   end
  # end
  

  
  resource :profile, only: [:show, :edit, :update] do
    get 'change_password', to: 'profiles#update_password'
  end



  resources :surveys, only: [:index, :new, :create,:show] do
    resources :questions, only: [:new, :create]
  end




  


end
