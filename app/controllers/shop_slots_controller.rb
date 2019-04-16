class ShopSlotsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :shop, through: :company
  load_and_authorize_resource :shop_slot, through: :shop

  def new
  end

  def create
    @shop_slot = ShopSlot.new(shop_slot_params.merge(shop_id: @shop.id))
    if @shop_slot.save
      flash[:success] = 'Shop appointment data has been created!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "Shop appointment data couldn't be created"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @shop_slot.update(shop_slot_params)
      flash[:success] = 'The shop slot has been updated!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "The shop slot couldn't be updated"
      render 'edit'
    end
  end

  private

  def shop_slot_params
    params.require(:shop_slot).permit(:day, :max_appointments, :open, :close,
                                      :shop_id)
  end
end
