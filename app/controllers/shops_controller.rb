class ShopsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @address = Address.new()
    @shop = Shop.new
  end

  def create
    @company = Company.find(params[:company_id])
    @address = Address.new(address_params)
    @shop = Shop.new(shop_params.merge(company_id: @company.id))
    @shop.address = @address
    if @shop.save
      redirect_to company_shop_path(@company, @shop)
    else
      render 'new'
    end
  end


  def show
    @shop = Shop.find(params[:id])
    @company = Company.find(params[:company_id])
  end

  def edit
    @shop = Shop.find(params[:id])
    @company = Company.find(params[:company_id])
  end

  def update
    @shop = Shop.find(params[:id])
    @company = Company.find(params[:company_id])
    @shop.address.update_attributes(address_params)
    if @shop.update_attributes(shop_params)
      redirect_to company_shop_path(@company, @shop)
    else
      render 'edit'
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    @shop.address.destroy
    @company = Company.find(params[:company_id])
    redirect_to company_shops_path(@company)
  end

  def index
    @company = Company.find(params[:company_id])
    @shops = Shop.all
  end

  private
  def shop_params
   params.require(:shop).permit(:name, :email)
  end

  def address_params
    # binding.pry
    params.require(:shop).require(:address).permit(:short_address, :full_address, :city, :zipcode, :country)
  end
end
