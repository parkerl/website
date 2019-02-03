class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ContactMailer.contact_email(params).deliver
    ContactMailer.thank_you_email(params[:name], params[:email]).deliver

    head :ok, content_type: "text/html"
  end
end
