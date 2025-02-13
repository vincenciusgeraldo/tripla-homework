Rails.application.routes.draw do
  resources :sleep_trackers, path: "sleep-trackers", only: [] do
    collection do
      get "followers" => "sleep_trackers#followers_sleep_trackers"
      post "sleep" => "sleep_trackers#record_sleep"
      post "awake" => "sleep_trackers#record_awake"
      get "me" => "sleep_trackers#my_sleep_trackers"
    end
  end
  resources :users, only: [] do
    member do
      post :follow
      post :unfollow
    end
  end

  post "auth/login" => "auth#login"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "posts#index"
end
