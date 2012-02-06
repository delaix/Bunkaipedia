class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha :private_key => '6LfQR80SAAAAAD9yObFtt9V4hgMrrFeXPbY0V-Yd'
      super
    else
      flash[:error] = "You may not be human!"
      redirect_to new_user_registration_path
    end
  end
end