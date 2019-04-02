class EmployeesController < ApplicationController
  load_and_authorize_resource

  def new
    @employee = Employee.new
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
  end

  def create
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @user = User.find(params[:employee][:user_id])
    @employee = Employee.new(employee_params.merge(user_id: @user.id,
                             shop_id: @shop.id, company_id: @company.id))
    if @employee.save
      flash[:success] = 'Employee has been added to the shop!'
      redirect_to company_shop_employee_path(@company, @shop, @employee)
    else
      flash[:danger] = "Employee couldn't be added to the shop!"
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @employee = Employee.find(params[:id])
    @shop = Shop.find(params[:shop_id])
  end

  def destroy
    @company = Company.find(params[:company_id])
    @shop = Company.find(params[:shop_id])
    @employee = Employee.find(params[:id])
    @employee.destroy
    if @employee.destroyed?
      flash[:success] = 'Employee has been deleted!'
      redirect_to company_shop_path(@company, @shop)
    else
      flash[:danger] = "Employee couldn't be deleted!"
      render 'show'
    end
  end

  def index
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @employees = Employee.all
  end

  def edit
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @employee = Employee.find(params[:id])
  end

  def update
    @company = Company.find(params[:company_id])
    @shop = Shop.find(params[:shop_id])
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
      flash[:success] = 'Employee has been updated!'
      redirect_to company_shop_employee_path(@company, @shop, @employee)
    else
      flash[:danger] = "Employee couldn't be updated!"
      render 'edit'
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:role, :user_id)
  end
end
