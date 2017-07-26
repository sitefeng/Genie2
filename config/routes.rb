Rails.application.routes.draw do

  get 'landing/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index'

  get 'landing/index'
  get 'activity/index'
  get 'my_requests/index'
  get 'my_answers/index'
  get 'settings/index'

  resources :request_advice, only: [] do
    collection do
      get 'index'
      post 'onSubmitQuestion'
      post 'onSubmitAdvice'
    end
  end

  resources :login, only: [] do
    collection do
      get 'index'
      post 'onLogin'
      post 'onSignup'
    end
  end

  get '/logout',  to: 'login#onLogout'

  get '/request_details/index/:id', :to => 'request_details#index', :as => 'request_details'


end
