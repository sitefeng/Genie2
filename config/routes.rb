Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Main Pages
  root 'landing#index'
  get 'landing/index'
  get 'activity/index'

  # My Request and Request Details
  get 'my_requests_questions/index'
  get 'my_requests_answers/index'
  get 'my_requests_favorited/index'
  get 'my_requests_starred/index'

  post "my_requests_favorited/:request_id", :to => "my_requests_favorited#create", :as => 'my_requests_favorited'

  get '/request_details/index/:id', :to => 'request_details#index', :as => 'request_details'


  # Request Advice
  resources :request_advice, only: [] do
    collection do
      get 'index'
      post 'onSubmitQuestion'
      post 'onSubmitAdvice'
    end
  end

  # User Account Management
  resources :login, only: [] do
    collection do
      get 'index'
      post 'onLogin'
      post 'onSignup'
    end
  end

  get 'settings/index'
  get '/logout',  to: 'login#onLogout'


  # Footer
  get 'about/index'
  get 'terms_of_service/index'
  get 'privacy_policy/index'

end
