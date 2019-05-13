module Api
  class ContactsController < ApplicationController
    def create
      respond_to do |format|
        format.json{
          render json: Contact.create(contact: @contact), name: params[:name],
                                                          email: params[:email]}
      end
    end
  end
end
