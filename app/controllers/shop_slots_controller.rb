class ShopSlotsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :shop, through: :company
  load_and_authorize_resource :shop_slot, through: :shop

  def new
  end

  def create
    @shop_slot = shopSlot.new(shop_slots_params.merge(shop_id: @shop.id))
    if @shop_slot.save
      flash[:success] = 'Shop appointment data has been created!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "Shop appointment data couldn't be created"
      render 'new'
    end
  end

  def show
  end

  private

  def shop_slots_params
    params.require(:shop_slot).permit(:day, :max_appointments, :open, :close, :closed)
  end
end
