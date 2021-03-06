module Api
  class ContactsController < ApplicationController
    def create
      @contact = Contact.new(contact_params)
      if @contact.save
        render json: @contact
      else
        render json: @contact.errors
      end
    end

    def index
      @contacts = Contact.all
      render json: @contacts
    end

    private

    def contact_params
      params.permit(:name, :email, :phone_number, :message, :user_id)
    end
  end
end
