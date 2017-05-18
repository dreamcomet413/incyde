class ConferencesController < ApplicationController

  load_and_authorize_resource

  def index
    @conferences = conferences
  end

  def show
    @conference = conferences.find(params[:id])
    redirect_to @conference.url # TODO Volver a poner en iframe cuando se instale un certificado SSL
  end

  private

  def conferences
    Conference.active.visible_for(current_user)
  end

end
