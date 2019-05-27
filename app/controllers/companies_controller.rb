class CompaniesController < ApplicationController
  load_and_authorize_resource
  def new
    @company = Company.new
  end

  def create
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
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
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
    @company = Company.find(params[:id])
    @company.destroy
    flash[:success] = 'The company has been deleted!'
    redirect_to companies_path
  end

  def index
    @companies = Company.all
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :active)
  end
end
