Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',

  }

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy', as: :sign_out
  end

  root 'assers#welcome'
  # resources :assers
  # resources :stores
  # resources :assers do
  #   resources :stories
  # end



  get 'checkout' , to: 'checkouts#show'
  get 'checkout/success' , to: 'checkouts#success'

  resources :assers do
    resources :stories do
      collection do
        get :export_csv
      end
    end
  end
  
  
  resource :profile, only: [:edit, :update] do
    get 'change_username'
    patch 'update_username'
  
    get 'change_password'
    patch 'update_password'
  end


  

  resources :surveys
  resources :questions do
    resources :answers
  end



  


end
