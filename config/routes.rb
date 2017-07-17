Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'activity#index'

  get 'activity/index'
  get 'my_requests/index'
  get 'my_answers/index'
  get 'settings/index'
  get 'request_advice/index'


end
