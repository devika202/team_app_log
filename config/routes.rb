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
      delete :destroy, action: :delete_team, as: :delete_team
      post :create_note
    end

    delete :leave_team, on: :member, as: :leave_team
  end
  resources :users do
    get :teams, on: :member
  end
  resources :notes
  delete '/notes/:id', to: 'notes#destroy', as: :delete_note
  patch '/teams/:team_id/notes/:id/update_note_access', to: 'notes#update_note_access', as: :update_note_access_team_note


  patch 'users/:id/update_role', to: 'users#update_role', as: :update_role
  get '/dashboard', to: 'dashboard#index', as: :dashboard

  get '/your_teams', to: 'teams#your_teams', as: :your_teams
  get '/joined_teams', to: 'teams#joined_teams', as: :joined_teams

  root 'dashboard#index'
end
