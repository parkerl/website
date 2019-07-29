class ApplicationController < ActionController::Base
  def index
  end

  def create
    if verify_recaptcha && params.include?(:name) && params.include?(:email) && params.include?(:message)
      ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver
      ContactMailer.thank_you_email(params[:name], params[:email]).deliver
    end

    redirect_to '/'
  end
end
