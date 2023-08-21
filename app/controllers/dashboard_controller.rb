class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @teams = Team.all
    
      @teams.each do |team|
        team.create_activity key: 'teams.dashboard', owner: current_user, parameters: { url: request.original_url }
      end
    end
    
  end