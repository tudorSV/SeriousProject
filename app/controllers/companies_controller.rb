class CompaniesController < ApplicationController

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Welcome to the website!"
      redirect_to @company
    else
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
      redirect_to @company
    else
         render 'edit'
    end
  end


  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to root_url
  end

  def index
    @companies = Company.all
  end

  private

      def company_params
        params.require(:company).permit(:name, :email)
      end
end

