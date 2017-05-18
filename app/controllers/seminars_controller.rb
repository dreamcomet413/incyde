class SeminarsController < ApplicationController

  authorize_resource

  def index
    #@seminars = Seminar.all
    @seminars = seminars
  end

  def show
    @seminar = seminars.find(params[:id])
  end

  private

  def seminars
    Seminar.active.visible_for(current_user)
  end

end
