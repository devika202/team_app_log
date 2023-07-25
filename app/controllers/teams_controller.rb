class TeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_team, only: [:show, :join, :update_manager, :create_note, :leave_team]
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

    def leave_team
      if @team && @team.members.include?(current_user)
        @team.members.delete(current_user)
        redirect_to dashboard_path, notice: "You have left the team."
      else
        redirect_to dashboard_path, alert: "Team not found or you are not a member of this team."
      end
    end

    
   

    def your_teams
    @teams = current_user.owned_teams
    redirect_to dashboard_path
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
      @team = Team.find(params[:id])
      @note = @team.notes.build
    end
  
    def create_note
      @team = Team.find(params[:id])
      @note = @team.notes.build(note_params)
      @note.user = current_user
  
      if @note.save
        redirect_to @team, notice: 'Note was successfully added.'
      else
        # Handle validation errors
        render 'show'
      end
    end
  
    def join
      @team.members << current_user
      redirect_to @team, notice: 'You have joined the team.'
    end
  
    def update_manager
      if current_user.admin?
        @team.manager = User.find(params[:manager_id])
        if @team.save
          redirect_to dashboard_path, notice: 'Team manager updated successfully.'
        else
          redirect_to dashboard_path, alert: 'Failed to update team manager.'
        end
      else
        redirect_to dashboard_path, alert: 'Access denied.'
      end
    end

    def delete_team
      @team = Team.find(params[:id])
      if current_user.admin?
        @team.destroy
        redirect_to dashboard_path, notice: "Team successfully deleted."
      else
        redirect_to dashboard_path, alert: "You are not authorized to delete this team."
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
      params.require(:note).permit(:title, :content, :access_level)
    end

    def record_not_found
      redirect_to dashboard_path, alert: "User or team not found."
    end
  
  end
  