class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :login_from_wp?
  before_action :check_legal_conditions
  #before_filter :reload_rails_admin, :if => :rails_admin_path?
  before_action :set_locale
  before_action :load_article_categories

  rescue_from CanCan::AccessDenied do |exception|
    # p "CanCan::AccessDenied => #{controller_path}##{action_name}"
    redirect_to main_app.root_path, :alert => exception.message
  end

  def login_from_wp?
    hash_wp_input_name = "9vX3FcEGBl1E9z7ZMoau" # String fijo para el 'name' del formulario de WP
    hash_wp_input_value = "LHWYtaYMIQI5Plc8ZB1S" # String fijo para el 'value' del formulario de WP
    controller_path == 'devise/sessions' && params[hash_wp_input_name] == hash_wp_input_value
  end

  #helper_method :current_user
  helper_method :featured_promotions
  helper_method :featured_news
  helper_method :next_seminars

  #def current_user
  #  current_admin || current_business_incubator || current_company
  #end

  def featured_promotions
    @featured_promotions ||= Article.visible_for(current_user).promotions.featured.ordered.limit(5)
  end

  def featured_news
    @featured_news ||= Article.visible_for(current_user).news.featured.ordered.limit(5)
  end

  def next_seminars
    @next_seminars ||= Seminar.next
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    WP_URL
  end

  def check_legal_conditions
    if current_user.present? && current_user.is_a?(Company) && !current_user.profile.legal_conditions
      redirect_to(edit_profile_path(anchor: 'company_data'), flash: {error: 'Debes aceptar las condiciones legales para poder continuar'})
    end
  end

  def set_locale
    locale = params[:locale].downcase if params[:locale] && params[:locale].downcase.in?(['es', 'en'])
    # I18n.locale = params[:locale] || I18n.default_locale
    session[:locale] = locale if locale.present?
    I18n.locale = locale || session[:locale] || I18n.default_locale
  end

  def load_article_categories
    @categories = ArticleCategory.all
  end

  #def reload_rails_admin
  #  models = %W(Article)
  #  models.each do |m|
  #    RailsAdmin::Config.reset_model(m)
  #  end
  #  RailsAdmin::Config::Actions.reset
  #
  #  load("#{Rails.root}/config/initializers/rails_admin.rb")
  #end
  #
  #def rails_admin_path?
  #  controller_path =~ /rails_admin/ && Rails.env == "development"
  #end

end
