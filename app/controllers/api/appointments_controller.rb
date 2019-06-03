module Api
  class AppointmentsController < ApplicationController
    def index
      @shop = Shop.find(params[:id])
      @appointments = Appointment.where(shop_id: params[:id])
      render json: @appointments
    end

    def date
      @shop = Shop.find(params[:id])
      @appointments = Appointment.where(shop_id: params[:id], date: params[:date])
      render json: @appointments
    end
  end
end
