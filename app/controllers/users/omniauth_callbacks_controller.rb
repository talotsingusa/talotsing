class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts "**********************************************************"
    puts @user
    puts "**********************************************************"

    if @user.persisted?
      puts "************************In the if of user persisted **********************************"
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      puts "In else************************************************************"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      puts "In redirect_to user url*********************************************"
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
   if @user.persisted?
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end 
  end

  def failure
    redirect_to root_path
  end
end
