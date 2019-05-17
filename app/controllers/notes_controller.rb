class NotesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:appointment_id])
    @note = Note.new
  end

  def create
    binding.pry
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:appointment_id])
    @note = Note.new(note_params.merge(appointment_id: @appointment.id))
    if @note.save
      flash[:success] = 'Note has been created'
      redirect_to user_appointment_index_note_path(@user, @appointment)
    else
      flash[:failure] = "The appointment couldn't be destroyed!"
      render 'new'
    end
  end

  def note
    @appointment = Appointment.find(params[:appointment_id])
    @notes = Note.all
  end
  private

  def note_params
    params.require(:note).permit(:message, :appointment_id)
  end
end
