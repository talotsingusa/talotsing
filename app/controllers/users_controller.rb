class UsersController < ApplicationController
  def index
    if current_user.email == "admin@gmail.com"
      @users = User.all
    else
      @users = User.where(email: "admin@gmail.com")
    end
    render layout: "dashboard_application"
  end
end
