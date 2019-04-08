class ShopSlotsController < ApplicationController
  # load_and_authorize_resource :company
  # load_and_authorize_resource :shop, through: :company
  # load_and_authorize_resource :shop_slot, through: :shop

  def new
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @shop_slot = ShopSlot.new
  end

  def create
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @shop_slot = ShopSlot.new(shop_slots_params.merge(shop_id: @shop.id))
    if @shop_slot.save
      flash[:success] = 'Shop appointment data has been created!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "Shop appointment data couldn't be created"
      render 'new'
    end
  end

  def show
    @shop_slot = ShopSlot.find(params[:id])
  end

  def edit
    @shop = Shop.find(params[:shop_id])
    @company = Company.find(params[:company_id])
    @shop_slot = ShopSlot.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:shop_id])
    @company = Company.find(params[:company_id])
    @shop_slot = ShopSlot.find(params[:id])
    if @shop_slot.update(shop_slots_params)
      flash[:success] = 'The shop slot has been updated!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "The shop slot couldn't be updated"
      render 'edit'
    end
  end

  def index
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @shop_slots = ShopSlot.where(shop_id: @shop.id)
  end

  private

  def shop_slots_params
    params.require(:shop_slot).permit(:day, :max_appointments, :open, :close,
                                      :closed, :shop_id)
  end
end
