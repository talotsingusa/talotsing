class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # def after_sign_in_path_for(resource)
  #   user = User.find(resource.id)
  #
  #   if resource.email  == "admin@gmail.com"
  #     dashboards_path
  #   elsif resource.profile_type == "vendor"
  #     dashboards_path
  #   elsif resource.profile_type == "customer"
  #    root_path
  #   else
  #     # do nothing
  #   end
  # end
end
