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
    get 'user/registration/confirm' => 'users#confirm_via_get'
    post 'user/registration/confirm' => 'users#confirm'
    post 'user/registration' => 'users#create'
    get 'my_page' => 'users#show'
  end

  namespace :admin do
    resources :events, except: [:destroy, :new] do
      resources :timetables, except: [:index, :destroy, :new] do
        resources :contents, except: [:index, :destroy, :new]
      end
    end
    resources :attendances, only: [:create, :destroy]
    post "users/qr", to: "users#qr", as: "user_qr"
  end

  namespace :api do
    namespace :v1 do
      post 'auth' => 'authorizations#create'
      delete 'auth' => 'authorizations#destroy'

      resources :users, only: [:index]
      resources :events, only: [:index] do
        resources :timetables, only: [:index] do
          resources :contents, only: [:index] do
            resources :attendances, only: [:index]
          end
        end
      end
    end
  end
end
