class CitySelectsController < ApplicationController

  # TODO verificar porque no funciona esto
  # authorize_resource class: :city_selects

  def regions
    render json: Region.by_country(params[:id]).ordered.to_json(only: [:id, :name])
  end

  def provinces
    render json: Province.by_region(params[:id]).ordered.to_json(only: [:id, :name])
  end

  def cities
    render json: City.by_province(params[:id]).ordered.to_json(only: [:id, :name])
  end

end
