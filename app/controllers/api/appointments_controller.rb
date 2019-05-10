module Api
  class AppointmentsController < ApplicationController
    def show
      # binding.pry
      @shop = Shop.find(params[:shop_id])
      # @appointments = Appointment.where("date.wday = ?", params[:wday] )
      # binding.pry
      # render json: @appointments
    end
  end
end
