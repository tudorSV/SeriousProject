class EmployeesController < ApplicationController

  # scope :same_id

  def new
    # @user = User.find(params[:user_id])
    @employee = Employee.new
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
  end

  def create
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @user = User.find(params[:employee][:user_id])
    @employee = Employee.new(employee_params.merge( user_id: @user.id,
                              shop_id: @shop.id, company_id: @company.id,
                              address_id: @user.address.id))
    if @employee.save
      redirect_to company_shop_employee_path(@company, @shop, @employee)
    else
      render 'new'
    end
  end


  def show
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @employee = Employee.find(params[:id])
  end


  def destroy
    @company = Company.find(params[:company_id])
    @shop = Company.find(params[:shop_id])
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to company_shop_path(@company, @shop)
  end


  private
  def employee_params
    params.require(:employee).permit(:role, :user_id)
  end

  def user_params
    params.require(:user).permit(:user_id)
  end

end
