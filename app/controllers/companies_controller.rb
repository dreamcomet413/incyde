class CompaniesController < ApplicationController

  load_and_authorize_resource

  autocomplete :sector, :name, full: true
  autocomplete :province, :name, full: true

  def index
    search = params[:search]
    companies = Company.active.includes(company_profile: [:sector, :city])
    if search.blank? || search.values.all?(&:blank?)
      @companies = companies
    else
      @companies = companies.search(search)
    end
  end

  def show
    @company = Company.active.find(params[:id])
  end

end
