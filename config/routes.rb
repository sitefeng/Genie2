Rails.application.routes.draw do
  get 'login/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'activity#index'

  get 'activity/index'
  get 'my_requests/index'
  get 'my_answers/index'
  get 'settings/index'

  resources :request

  resources :request_advice, only: [] do
    collection do
      get 'index'
      post 'onSubmitQuestion'
      post 'onSubmitAdvice'
    end
  end

end
