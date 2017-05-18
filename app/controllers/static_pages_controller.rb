class StaticPagesController < ApplicationController

  skip_before_action :check_legal_conditions

  def legal_conditions
  end

end
