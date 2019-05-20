class NotesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:appointment_id])
    @note = Note.new
  end

  def create
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:appointment_id])
    @note = Note.create!(note_params.merge(appointment_id: @appointment.id))
      respond_to do |format|
        @notes = Note.where(appointment_id: @appointment.id)
        format.html { redirect_to user_appointment_path(@user, @appointment) }
        format.js
      end
  end

  def index
    @appointment = Appointment.find(params[:appointment_id])
    @notes = Note.where(appointment_id: @appointment.id)
  end

  private

  def note_params
    params.require(:note).permit(:message, :appointment_id)
  end
end
