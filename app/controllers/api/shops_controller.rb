module Api
  class ShopsController < ApplicationController
    def index
      @company = Company.find(params[:id])
      @shops = Shop.all.where(company_id: params[:id])
      render json: @shops
    end

    def all_shops
      @shops = Shop.all
      render json: @shops
    end
  end
end
