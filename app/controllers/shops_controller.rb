class ShopsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @shop = Shop.new
    @address = @shop.build_address
  end

  def create
    @company = Company.find(params[:company_id])
    @shop = Shop.new(shop_params.merge(address_params).merge(company_id: @company.id))
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
    if @shop.update(shop_params.merge(address_params))
      flash[:success] = "The shop has been updated!"
      return redirect_to company_shop_path(@company, @shop)
    else
      flash[:failure] = "The shop couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
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
    params.require(:shop).permit(address_attributes: [:short_address, :full_address, :city, :zipcode, :country] )
  end
end
