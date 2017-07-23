Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'activity#index'

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

end
