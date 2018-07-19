class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    render layout: "plain_application"
  end

  # overwrite devise's create method to render out layout
  def create
    user = User.new(sign_up_params)
    user.profile_type = params[:user][:profile_type]
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    customer = Stripe::Customer.create(email: user.email)
    user.customer_id = customer.id
    if user.save
      redirect_to dashboards_path
    else
      redirect_to new_user_registration_path
    end
  end

  private

  # def after_sign_up_path_for(resource)
  #   redirect_to new_user_session_path, flash[:notice] = "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
  # end

  def after_update_path_for(resource)
    # if current_user.profile_type == "Landlord"
    #   if params[:user][:first_name].present?
    #     edit_landlord_path(current_user.profile_id)
    #   else
    #     edit_user_registration_path
    #   end
    # else
    #   if params[:user][:first_name].present?
    #     edit_tenant_path(current_user.profile_id)
    #   else
    #     edit_user_registration_path
    #   end
    # end
  end

  def update_resource(resource, params)
    if params[:password].present? && params[:password_confirmation].present?
      resource.update(account_update_params)
    else
      resource.update_without_password(params)
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name,  :email, :password, :password_confirmation, :profile_type)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end