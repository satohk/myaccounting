class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    sent_mail_path
  end

  def sent_mail
    render :sent_mail
  end
end
