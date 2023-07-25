class TeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_team, only: [:show, :join, :update_manager, :create_note]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


    def new
      @team = Team.new
      @managers = User.where(role: 'manager')
    end
  
    def create
      @team = Team.new(team_params)
      if @team.save
        redirect_to @team, notice: 'Team created successfully.'
      else
        @managers = User.where(role: 'manager')
        render :new
      end
    end

    def your_teams
    @teams = current_user.owned_teams
    redirect_to teams_path
    end
  
    def joined_teams
      @teams = current_user.teams
    end

    def remove_member
        @team = Team.find(params[:id])
        @user = User.find(params[:user_id])
      
      if current_user.admin? || @team.manager == current_user
        @team.members.delete(@user)
        redirect_to @team, notice: "Member removed from the team."
      else
        redirect_to @team, alert: "Access denied. You are not authorized to remove members from this team."
      end
    end
  
    def index
      if current_user.admin?
        @teams = Team.all
      elsif current_user.manager?
        @teams = current_user.owned_teams
      else
        @teams = current_user.teams
      end
  
      @managers = User.where(role: 'manager') 
    end
  
  
    def show
      @note = @team.notes.build(user: current_user)
    end
  
    def create_note
      @note = @team.notes.build(note_params)
      @note.user = current_user
      @note.save
      redirect_to @team, notice: 'Note was successfully added.'
    end
  
    def join
      @team.members << current_user
      redirect_to @team, notice: 'You have joined the team.'
    end
  
    def update_manager
      if current_user.admin?
        @team.manager = User.find(params[:manager_id])
        if @team.save
          redirect_to teams_path, notice: 'Team manager updated successfully.'
        else
          redirect_to teams_path, alert: 'Failed to update team manager.'
        end
      else
        redirect_to teams_path, alert: 'Access denied.'
      end
    end

    private

    def team_params
      params.require(:team).permit(:name, :description, :manager_id)
    end

    def find_team
      @team = Team.find(params[:id])
    end
  
    def note_params
      params.require(:note).permit(:content, :access_level)
    end

    def record_not_found
      redirect_to teams_path, alert: "User or team not found."
    end
  
  end
  