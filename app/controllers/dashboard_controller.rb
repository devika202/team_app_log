class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @teams = Team.all
    
      @teams.each do |team|
        team.create_activity key: 'teams.dashboard', owner: current_user
      end
    end
    
  end