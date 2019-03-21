class EmployeesController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @employee = Employee.new
  end

  def create
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @user = User.find(params[:username])
    @employee = Employee.new(employee_params.merge(address_id: @user.address.id, user_id: @user.username,shop_id: @shop.id, company_id: @company.id))
    if @employee.save
      redirect_to company_shop_employee_path(@company, @shop, @employee)
    else
      render 'new'
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:role)
  end

end
