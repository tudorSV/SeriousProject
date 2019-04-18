class ShopsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :shop, through: :company

  def new
    @address = @shop.build_address
  end

  def create
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
    @slots = @shop.shop_slots.order('day ASC')
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

  def index_appointment
    @company = Company.find(params[:company_id])
    authorize! :show, @company
    @shop = Shop.find(params[:shop_id])
    authorize! :show, @shop
    @appointments = Appointment.where(shop_id: @shop.id)
  end

  def change_status
    @company = Company.find(params[:company_id])
    authorize! :show, @company
    @shop = Shop.find(params[:shop_id])
    authorize! :show, @shop
    @appointment = Appointment.find(params[:appointment])
    if @appointment.status == 'Booked'
      @appointment.update(status: 'Ready for pickup')
      flash[:success] = 'The appointment has been updated to ready for pickup!'
      return redirect_to company_shop_index_appointment_path(@company, @shop)
    elsif @appointment.status == 'Ready for pickup'
      @appointment.update(status: 'Finished')
      flash[:success] = 'The appointment has been completed!'
      return redirect_to company_shop_index_appointment_path(@company, @shop)
    else
      flash[:danger] = "The appointment couldn't updated!"
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :email, :active)
  end

  def address_params
    params.require(:shop).permit(address_attributes: [:short_address, :full_address, :city, :zipcode, :country])
  end
end
