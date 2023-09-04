Rails.application.routes.draw do
  scope module: :common do
    # homes controller
    root to: 'homes#top'

    # authentications controller
    get 'auth' => 'authentications#new'
    post 'auth' => 'authentications#create'
    get 'auth/sent' => 'authentications#sent'
    get 'token' => 'authentications#token'

    # sessions controller
    delete 'session' => 'sessions#destroy'
  end

  scope module: :public do
    # users controller
    get 'user/registration' => 'users#new'
    post 'user/registration/confirm' => 'users#confirm'
    post 'user/registration' => 'users#create'
    get 'my_page' => 'users#show'
  end

  namespace :admin do
    resources :events, except: [:destroy] do
      resources :timetables, except: [:index, :destroy] do
        resources :contents, except: [:index, :destroy]
      end
    end
    resources :attendances, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      get 'auth' => 'authorizations#new'
      delete 'auth' => 'authorizations#destroy'

      resources :users, only: [:index]
      resources :events, only: [:index, :show] do
        resources :timetables, only: [:index] do
          resources :contents, only: [:index] do
            resources :attendances, only: [:index]
          end
        end
      end
    end
  end
end
