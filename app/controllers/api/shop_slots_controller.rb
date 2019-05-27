module Api
  class ShopSlotsController < ApplicationController
    def index
      @shop = Shop.find(params[:id])
      @shop_slots = ShopSlot.where(shop_id: params[:id])
      render json: @shop_slots
    end
  end
end
