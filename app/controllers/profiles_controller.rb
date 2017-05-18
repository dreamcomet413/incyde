class ProfilesController < ApplicationController

  authorize_resource class: :profile
  skip_before_action :check_legal_conditions

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    #if @user.update_attributes(user_params)
    method_to_update = user_params["password"].blank? ? :update_without_password : :update_attributes
    if @user.send(method_to_update, user_params)
      sign_in(@user, bypass: true)
      #redirect_to edit_profile_path(@user)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    attrs = [:avatar, :password, :password_confirmation] # Atributos comunes
    if @user.is_a?(Company)
      attrs += [company_profile_attributes: [
          :id,
          :contact_name, :contact_surname,
          :name, :incorporation_date, :cnae, :workers_number,
          :land_phone, :mobile_phone, :fax, :activity, :web, :offer_description,
          :legal_conditions
        ]
      ]
    else
      attrs += [business_incubator_profile_attributes: [:id, :name,:contact_name, :phone, :fax, :web, :facebook_url, :twitter_url]]
    end
    params.require(@user.class.name.underscore).permit(attrs)
  end

end
