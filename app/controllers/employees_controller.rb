class EmployeesController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :shop, through: :company
  load_and_authorize_resource :employee, through: :shop

  def new
  end

  def create
    @user = User.find(params[:employee][:user_id])
    @employee = Employee.new(employee_params.merge(user_id: @user.id, address_id: @user.address_id,
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
  end

  def destroy
    @employee.destroy
    if @employee.destroyed?
      flash[:success] = 'Employee has been deleted!'
      redirect_to company_shop_employees_path(@company, @shop)
    else
      flash[:danger] = "Employee couldn't be deleted!"
      render 'show'
    end
  end

  def index
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
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
