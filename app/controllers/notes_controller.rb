class NotesController < ApplicationController
    before_action :authenticate_user!
    
    def show
      @note = Note.find(params[:id])
      @note.create_activity key: 'note.notesshowpage', owner: current_user, parameters: { url: request.original_url }
      @team = @note.team
    end

    def update_note_access
      @note = Note.find(params[:note_id])
      @note.create_activity key: 'note.accessupdate', owner: current_user, parameters: { url: request.original_url }
      @note.update(access_level: params[:access_level])
      redirect_to @note, notice: 'Note access level was successfully updated.'
    end

    def destroy
      @note = Note.find(params[:id])
      @note.create_activity key: 'note.destroynote', owner: current_user, parameters: { url: request.original_url }

      @note.destroy
      redirect_to dashboard_path, notice: 'Note was successfully deleted.'
    end

  private

  def note_params
    params.require(:note).permit(:title, :content, :access_level)
  end
end