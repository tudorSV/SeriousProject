class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    authorize! :create, current_user
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = 'The company has been created!'
      redirect_to @company
    else
      flash[:failure] = "The company couldn't be created!"
      render 'new'
    end
  end

  def show
    authorize! :show, current_user
    @company = Company.find(params[:id])
  end

  def edit
    authorize! :edit, current_user
    @company = Company.find(params[:id])
  end

  def update
    authorize! :update, current_user
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = 'The company has been updated!'
      redirect_to @company
    else
      flash[:failure] = "The company couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, current_user
    @company = Company.find(params[:id])
    @company.destroy
    flash[:success] = 'The company has been deleted!'
    redirect_to companies_path
  end

  def index
    authorize! :index, current_user
    @companies = Company.all
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :active)
  end
end
