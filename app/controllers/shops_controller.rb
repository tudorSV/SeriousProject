class ShopsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @address = Address.new()
    @shop = Shop.new
  end

  def create
    @company = Company.find(params[:company_id])
    @address = Address.new()
    @shop = Shop.new(shop_params.merge(company_id: @company.id))
    if @shop.save
      redirect_to @shop
    else
      render 'new'
    end
  end

  private
  def shop_params
   params.require(:shop).permit(:name, :email)
  end

  def address_params
    params.require(:address).permit(:short_address, :full_address, :city, :zipcode, :country)
  end
end
