class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if params.include?(:name) && params.include?(:email) && params.include?(:message)
      ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver
      ContactMailer.thank_you_email(params[:name], params[:email]).deliver
    end

    head :ok, content_type: "text/html"
  end
end
