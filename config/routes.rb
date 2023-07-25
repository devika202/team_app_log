Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      put :assign_team
    end
  end

  resources :teams do
    member do
      post :join
      patch :update_manager
      delete :remove_member
    end
  end

  resources :users do
    get :teams, on: :member
  end

  patch 'users/:id/update_role', to: 'users#update_role', as: :update_role
  get '/dashboard', to: 'dashboard#index', as: :dashboard

  # Define your_teams and joined_teams routes before the root route
  get '/your_teams', to: 'teams#your_teams', as: :your_teams
  get '/joined_teams', to: 'teams#joined_teams', as: :joined_teams

  root 'dashboard#index'
end
