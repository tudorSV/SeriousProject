class ShopsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :shop, through: :company

  def new
    @company = Company.find(params[:company_id])
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
    return redirect_to company_shops_path if @shop.blank?
  end

  def edit
    return redirect_to company_shops_path if @shop.blank?
  end

  def update
    if @shop.update(shop_params.merge(address_params))
      flash[:success] = 'The shop has been updated!'
      return redirect_to company_shop_path(@company, @shop)
    else
      flash[:failure] = "The shop couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    @shop.destroy
    flash[:success] = 'The shop has been deleted!'
    redirect_to company_shops_path(@company)
  end

  def index
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :email, :active)
  end

  def address_params
    params.require(:shop).permit(address_attributes: [:short_address, :full_address, :city, :zipcode, :country])
  end
end
