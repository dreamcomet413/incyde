class SwitchUsersController < ApplicationController

  authorize_resource class: :switch_user

  def show
    user = current_user.accounts_to_manage.find(params[:id])
    sign_in(:user, user)
    redirect_to edit_profile_path(current_user)
  end

end
