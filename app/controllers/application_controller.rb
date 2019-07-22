class ApplicationController < ActionController::Base
  def index
    @posts = FeedReader.new.items.map do |post|
      PostPresenter.new.present(post)
    end
  end

  def create
    if verify_recaptcha && params.include?(:name) && params.include?(:email) && params.include?(:message)
      ContactMailer.contact_email(params[:name], params[:email], params[:message]).deliver
      ContactMailer.thank_you_email(params[:name], params[:email]).deliver
    end

    redirect_to '/'
  end
end
