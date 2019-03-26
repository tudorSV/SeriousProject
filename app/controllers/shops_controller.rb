class ShopsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @address = Address.new
    @shop = Shop.new
  end

  def create
    @company = Company.find(params[:company_id])
    @address = Address.new(address_params)
    @shop = Shop.new(shop_params.merge(company_id: @company.id))
    @shop.address = @address
    if @shop.save
      flash[:success] = 'The shop has been created!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:failure] = "The couldn't be created!"
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @shop = Shop.find_by(id: params[:id], company_id: params[:company_id])
    return redirect_to company_shops_path if @shop.blank?
  end

  def edit
    @company = Company.find(params[:company_id])
    @shop = Shop.find_by(id: params[:id], company_id: params[:company_id])
    return redirect_to company_shops_path if @shop.blank?
  end

  def update
    @company = Company.find(params[:company_id])
    @shop = Shop.find_by(id: params[:id], company_id: params[:company_id])
    ActiveRecord::Base.transaction do
      @shop.address.update!(address_params)
      @shop.update!(shop_params)
      flash[:success] = 'The shop has been updated!'
      redirect_to company_shop_path(@company, @shop)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:failure] = "The couldn't be updated!"
    render 'edit'
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    @shop.address.destroy
    @company = Company.find(params[:company_id])
    flash[:success] = 'The shop has been deleted!'
    redirect_to company_shops_path(@company)
  end

  def index
    @company = Company.find(params[:company_id])
    @shops = @company.shops
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :email)
  end

  def address_params
    params.require(:shop).require(:address).permit(:short_address, :full_address, :city, :zipcode, :country)
  end

  def company_params
    params.require(:shop).require(:company).permit(:company_id)
  end
end
