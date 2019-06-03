class NotesController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :appointment, through: :user
  load_and_authorize_resource :note, through: :appointment

  def new
  end

  def create
    @note = Note.create!(note_params.merge(appointment_id: @appointment.id, user_id: @user.id))
    respond_to do |format|
      @notes = Note.where(appointment_id: @appointment.id)
      format.html { redirect_to user_appointment_path(@user, @appointment) }
      format.js
    end
  end

  private

  def note_params
    params.require(:note).permit(:message, :appointment_id, :user_id)
  end
end
