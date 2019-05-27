class CompaniesController < ApplicationController
  load_and_authorize_resource
  def new
  end

  def create
    if @company.save
      flash[:success] = 'The company has been created!'
      redirect_to @company
    else
      flash[:failure] = "The company couldn't be created!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @company.update_attributes(company_params)
      flash[:success] = 'The company has been updated!'
      redirect_to @company
    else
      flash[:failure] = "The company couldn't be updated!"
      render 'edit'
    end
  end

  def destroy
    @company.destroy
    flash[:success] = 'The company has been deleted!'
    redirect_to companies_path
  end

  def index
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :active)
  end
end
